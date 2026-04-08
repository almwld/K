import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

interface EmailRequest {
  to: string
  subject: string
  template: 'welcome' | 'order_confirmation' | 'password_reset' | 'payment_success' | 'order_shipped'
  data: {
    name?: string
    orderId?: string
    amount?: number
    resetLink?: string
    trackingNumber?: string
    items?: Array<{ name: string; quantity: number; price: number }>
  }
}

const EMAIL_TEMPLATES = {
  welcome: {
    subject: 'مرحباً بك في فلكس اليمن! 🎉',
    html: (data: any) => `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>مرحباً بك في فلكس اليمن</title>
        <style>
          body { font-family: 'Tahoma', Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { text-align: center; padding: 20px; background: linear-gradient(135deg, #D4AF37, #FFD700); border-radius: 10px 10px 0 0; }
          .logo { font-size: 28px; font-weight: bold; color: #000; }
          .content { padding: 30px; background: #fff; border: 1px solid #e0e0e0; }
          .button { display: inline-block; padding: 12px 24px; background: #D4AF37; color: #000; text-decoration: none; border-radius: 5px; margin: 20px 0; }
          .footer { text-align: center; padding: 20px; font-size: 12px; color: #666; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <div class="logo">✨ فلكس اليمن ✨</div>
          </div>
          <div class="content">
            <h2>مرحباً ${data.name || 'عميلنا العزيز'}! 👋</h2>
            <p>شكراً لانضمامك إلى <strong>فلكس اليمن</strong> - منصة التجارة الإلكترونية الرائدة في اليمن.</p>
            <p>نحن سعداء بوجودك معنا! استعد لاكتشاف أفضل العروض والمنتجات من جميع أنحاء اليمن.</p>
            <div style="text-align: center;">
              <a href="https://flexyemen.com/shop" class="button">🛍️ تسوق الآن</a>
            </div>
            <p>مع فلكس اليمن، يمكنك:</p>
            <ul>
              <li>✅ التسوق من آلاف المتاجر الموثوقة</li>
              <li>✅ دفع آمن عبر محفظتك الرقمية</li>
              <li>✅ توصيل سريع إلى جميع المحافظات</li>
              <li>✅ عروض حصرية وكوبونات خصم يومية</li>
            </ul>
          </div>
          <div class="footer">
            <p>© 2024 فلكس اليمن - منصة التجارة الإلكترونية اليمنية</p>
            <p>📍 صنعاء، اليمن | 📞 777777777 | ✉️ support@flexyemen.com</p>
          </div>
        </div>
      </body>
      </html>
    `
  },
  order_confirmation: {
    subject: 'تم تأكيد طلبك #{{orderId}} 🎯',
    html: (data: any) => `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <title>تأكيد الطلب - فلكس اليمن</title>
        <style>
          body { font-family: 'Tahoma', Arial, sans-serif; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: #D4AF37; padding: 20px; text-align: center; border-radius: 10px 10px 0 0; }
          .order-details { background: #f9f9f9; padding: 15px; border-radius: 10px; margin: 20px 0; }
          .total { font-size: 18px; font-weight: bold; color: #D4AF37; }
          .track-btn { background: #D4AF37; color: #000; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h2>✅ تم تأكيد طلبك بنجاح!</h2>
          </div>
          <div class="content">
            <p>شكراً لتسوقك من <strong>فلكس اليمن</strong> يا ${data.name || 'عميلنا العزيز'}!</p>
            <div class="order-details">
              <h3>📦 تفاصيل الطلب</h3>
              <p><strong>رقم الطلب:</strong> #${data.orderId}</p>
              <p><strong>المبلغ الإجمالي:</strong> ${data.amount} ر.ي</p>
              <h4>المنتجات:</h4>
              <ul>
                ${data.items?.map((item: any) => `<li>${item.name} × ${item.quantity} - ${item.price} ر.ي</li>`).join('') || '<li>جاري التحميل...</li>'}
              </ul>
            </div>
            <div style="text-align: center;">
              <a href="https://flexyemen.com/orders/${data.orderId}" class="track-btn">🔍 تتبع طلبك</a>
            </div>
            <p>سنقوم بإعلامك عند شحن طلبك. شكراً لثقتك بنا! 💛</p>
          </div>
          <div class="footer">
            <p>© 2024 فلكس اليمن - التسوق بثقة</p>
          </div>
        </div>
      </body>
      </html>
    `
  },
  payment_success: {
    subject: 'تم استلام دفعتك بنجاح 💰',
    html: (data: any) => `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <title>تأكيد الدفع - فلكس اليمن</title>
        <style>
          body { font-family: 'Tahoma', Arial, sans-serif; }
          .success-icon { font-size: 64px; text-align: center; }
          .amount { font-size: 32px; color: #D4AF37; font-weight: bold; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="success-icon">✅</div>
          <h2 style="text-align: center;">تم استلام دفعتك بنجاح!</h2>
          <p>مرحباً ${data.name}،</p>
          <p>نؤكد استلام مبلغ <span class="amount">${data.amount} ر.ي</span> للطلب #${data.orderId}.</p>
          <p>سيتم تجهيز طلبك وشحنه خلال 24 ساعة.</p>
          <div style="text-align: center;">
            <a href="https://flexyemen.com/orders/${data.orderId}" class="button">📱 متابعة الطلب</a>
          </div>
        </div>
      </body>
      </html>
    `
  }
}

serve(async (req) => {
  try {
    const { to, subject, template, data } = await req.json() as EmailRequest
    
    // التحقق من صحة البيانات
    if (!to || !template) {
      return new Response(
        JSON.stringify({ error: 'Missing required fields: to, template' }),
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // الحصول على القالب
    const emailTemplate = EMAIL_TEMPLATES[template]
    if (!emailTemplate) {
      return new Response(
        JSON.stringify({ error: 'Invalid template' }),
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // تخصيص الموضوع والقالب
    const finalSubject = emailTemplate.subject.replace(/{{(.*?)}}/g, (_, key) => data[key] || '')
    const htmlContent = emailTemplate.html(data)

    // هنا يمكنك إضافة خدمة إرسال البريد الإلكتروني
    // مثال باستخدام Resend API
    const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')
    
    if (RESEND_API_KEY) {
      const emailResponse = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${RESEND_API_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          from: 'Flex Yemen <noreply@flexyemen.com>',
          to: [to],
          subject: finalSubject,
          html: htmlContent,
        }),
      })
      
      const result = await emailResponse.json()
      return new Response(
        JSON.stringify({ success: true, messageId: result.id }),
        { status: 200, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // محاكاة إرسال البريد (للتطوير)
    console.log('📧 Email would be sent to:', to)
    console.log('📝 Subject:', finalSubject)
    
    return new Response(
      JSON.stringify({ 
        success: true, 
        message: 'Email queued successfully',
        preview: htmlContent 
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
