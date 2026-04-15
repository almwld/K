import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'

const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')

serve(async (req) => {
  try {
    const { user } = await req.json()
    
    const emailHtml = `
      <!DOCTYPE html>
      <html dir="rtl" lang="ar">
      <head>
        <meta charset="UTF-8">
        <title>مرحباً بك في فلكس اليمن</title>
        <style>
          body { font-family: 'Tajawal', sans-serif; background: #f5f5f5; padding: 20px; }
          .container { max-width: 600px; margin: 0 auto; background: white; border-radius: 20px; overflow: hidden; }
          .header { background: linear-gradient(135deg, #D4AF37, #FFD700); padding: 30px; text-align: center; }
          .logo { font-size: 28px; font-weight: bold; color: #000; }
          .content { padding: 30px; }
          .button { background: #D4AF37; color: #000; padding: 12px 30px; text-decoration: none; border-radius: 25px; display: inline-block; }
          .footer { background: #f8f9fa; padding: 20px; text-align: center; font-size: 12px; color: #666; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <div class="logo">🛍️ فلكس اليمن</div>
          </div>
          <div class="content">
            <h2>مرحباً ${user.user_metadata?.name || 'عميلنا العزيز'}! 👋</h2>
            <p>شكراً لانضمامك إلى <strong>فلكس اليمن</strong> - منصة التجارة الإلكترونية الرائدة في اليمن.</p>
            <p>نحن سعداء بوجودك معنا! استكشف آلاف المنتجات واستمتع بعروض حصرية.</p>
            <div style="text-align: center; margin: 30px 0;">
              <a href="https://flexyemen.com/shop" class="button">🛒 ابدأ التسوق الآن</a>
            </div>
            <p>🎁 كود خصم ترحيبي: <strong>WELCOME10</strong> (خصم 10%)</p>
          </div>
          <div class="footer">
            © 2024 فلكس اليمن - جميع الحقوق محفوظة
          </div>
        </div>
      </body>
      </html>
    `
    
    if (RESEND_API_KEY) {
      await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${RESEND_API_KEY}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          from: 'Flex Yemen <noreply@resend.dev>',
          to: [user.email],
          subject: '🎉 مرحباً بك في فلكس اليمن!',
          html: emailHtml,
        }),
      })
    }
    
    return new Response(JSON.stringify({ success: true }), { status: 200 })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }
})
