import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  try {
    const { orderId, action } = await req.json()
    
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )

    // جلب بيانات الطلب
    const { data: order, error: orderError } = await supabaseClient
      .from('orders')
      .select('*, user:user_id(email, name)')
      .eq('id', orderId)
      .single()

    if (orderError) throw orderError

    switch (action) {
      case 'confirm':
        // تحديث حالة الطلب
        await supabaseClient
          .from('orders')
          .update({ status: 'confirmed', confirmed_at: new Date().toISOString() })
          .eq('id', orderId)
        
        // إرسال إشعار تأكيد
        await fetch(`${Deno.env.get('SUPABASE_URL')}/functions/v1/send-notification`, {
          method: 'POST',
          headers: { 'Authorization': req.headers.get('Authorization')! },
          body: JSON.stringify({
            userId: order.user_id,
            title: '✅ تم تأكيد طلبك',
            body: `طلبك #${orderId} تم تأكيده بنجاح`,
            type: 'order',
            data: { orderId: orderId }
          })
        })
        
        // إرسال بريد إلكتروني
        await fetch(`${Deno.env.get('SUPABASE_URL')}/functions/v1/send-email`, {
          method: 'POST',
          body: JSON.stringify({
            to: order.user.email,
            template: 'order_confirmation',
            data: {
              name: order.user.name,
              orderId: orderId,
              amount: order.total_amount
            }
          })
        })
        break
        
      case 'cancel':
        await supabaseClient
          .from('orders')
          .update({ status: 'cancelled', cancelled_at: new Date().toISOString() })
          .eq('id', orderId)
        break
        
      case 'ship':
        await supabaseClient
          .from('orders')
          .update({ status: 'shipped', shipped_at: new Date().toISOString() })
          .eq('id', orderId)
        break
    }

    return new Response(
      JSON.stringify({ success: true, orderId: orderId, action: action }),
      { status: 200, headers: { 'Content-Type': 'application/json' } }
    )
    
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    )
  }
})
