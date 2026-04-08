#!/bin/bash

# إضافة المفاتيح السرية
supabase secrets set RESEND_API_KEY="re_your_resend_api_key"
supabase secrets set SUPABASE_URL="https://ziqpohdxtermunnhlkm.supabase.co"
supabase secrets set SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

echo "✅ Secrets configured successfully!"
