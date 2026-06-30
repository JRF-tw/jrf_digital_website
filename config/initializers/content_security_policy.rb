# Be sure to restart your server when you modify this file.
#
# Content Security Policy (CSP).
#
# This is a pragmatic baseline tuned for THIS app, which relies heavily on inline
# scripts/styles (Material Design Lite, Google Tag Manager, Slim templates with
# inline `style=`). A strict nonce-based policy would break those, so we keep
# 'unsafe_inline' for script/style but still lock down the high-value directives
# (object-src, base-uri, frame-ancestors) that stop plugin injection, <base> tag
# hijacking and clickjacking.
#
# To tighten later: drop ':unsafe_inline'/':https' from script_src, enumerate the
# exact Google Tag Manager / Analytics hosts, and add a nonce generator.
#
# To test without enforcing (collect violations only), set:
#   config.content_security_policy_report_only = true

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.base_uri    :self
  policy.object_src  :none
  policy.frame_ancestors :self

  # Stylesheets: app assets, Google Fonts / Material Icons CSS, inline styles.
  policy.style_src  :self, :https, :unsafe_inline

  # Fonts: Google Fonts (gstatic) + data: URIs.
  policy.font_src   :self, :https, :data

  # Images: app uploads (self), remote http/https record images, data: URIs.
  policy.img_src    :self, :https, :http, :data

  # Scripts: app assets, Google Tag Manager / Analytics, inline bootstrap snippets.
  # 'unsafe_eval' is required by the Redactor rich-text editor used in the admin.
  # It's a small extra relaxation given 'unsafe_inline' is already unavoidable here;
  # the real protection comes from default-src/object-src/base-uri/frame-ancestors.
  policy.script_src :self, :https, :unsafe_inline, :unsafe_eval

  # XHR / analytics beacons.
  policy.connect_src :self, :https

  # Login forms post to the app itself.
  policy.form_action :self
end
