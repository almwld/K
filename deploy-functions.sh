#!/bin/bash

# نشر Edge Functions إلى Supabase
echo "🚀 Deploying Edge Functions to Supabase..."

# تسجيل الدخول إلى Supabase
supabase login

# ربط المشروع
supabase link --project-ref "ziqpohdxtermunnhlkm"

# نشر الوظائف
supabase functions deploy send-email --no-verify-jwt
supabase functions deploy send-notification
supabase functions deploy process-order

echo "✅ All functions deployed successfully!"
