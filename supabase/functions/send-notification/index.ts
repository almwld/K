import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

interface NotificationRequest {
  userId: string
  title: string
  body: string
  type: 'order' | 'promotion' | 'payment' | 'system'
  data?: Record<string, any>
}

serve(async (req) => {
  try {
    const { userId, title, body, type, data } = await req.json() as NotificationRequest
    
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')! } } }
    )

    // حفظ الإشعار في قاعدة البيانات
    const { data: notification, error } = await supabaseClient
      .from('notifications')
      .insert({
        user_id: userId,
        title: title,
        body: body,
        type: type,
        data: data || {},
        is_read: false,
        created_at: new Date().toISOString()
      })
      .select()
      .single()

    if (error) throw error

    // هنا يمكن إضافة خدمة FCM للإشعارات الفورية
    // const fcmResponse = await sendFCMNotification(userId, title, body)

    return new Response(
      JSON.stringify({ 
        success: true, 
        notification: notification,
        message: 'Notification sent successfully' 
      }),
      { status: 200, headers: { 'Content-Type': 'application/json' } }
    )
    
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    )
  }
})
