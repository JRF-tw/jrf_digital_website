# frozen_string_literal: true

# OmniAuth 2.0+ hardening
# Reference: https://github.com/omniauth/omniauth/wiki/Resolving-CVE-2015-9284

# Only allow POST requests to initiate the OAuth request phase. This alone
# mitigates the simplest CSRF-via-GET attacks (e.g. <img src=".../auth/google">).
OmniAuth.config.allowed_request_methods = [:post]

# CSRF protection for the request phase is provided by the
# `omniauth-rails_csrf_protection` gem, which installs a request_validation_phase
# that verifies Rails' authenticity token. All OAuth login buttons in this app use
# `button_to ... method: :post`, so they already submit a valid authenticity_token.
#
# NOTE: do NOT set `OmniAuth.config.request_validation_phase = nil` here — that would
# disable the gem's protection and re-open the login-CSRF vulnerability.
# OmniAuth failure handling is left to Devise's default configuration.
