# Be sure to restart your server when you modify this file.

# Cookie session hardening:
# - httponly: keep the session cookie out of reach of JavaScript (XSS mitigation).
# - secure: only send the cookie over HTTPS in production (visitors reach the site
#   over HTTPS via Cloudflare). Left off in development/test so http://localhost works.
# - same_site: :lax blocks the cookie on cross-site POST/AJAX (CSRF mitigation) while
#   still allowing it on the top-level GET redirect back from Google/Facebook OAuth.
Rails.application.config.session_store :cookie_store,
  key: '_jrf_digital_website_session',
  httponly: true,
  secure: Rails.env.production?,
  same_site: :lax
