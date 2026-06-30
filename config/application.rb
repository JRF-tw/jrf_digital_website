require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JrfDigitalWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Taipei'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-TW"

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.exceptions_app = self.routes

    # Security response headers (merged on top of Rails' defaults: X-Frame-Options
    # SAMEORIGIN, X-Content-Type-Options nosniff, X-Download-Options noopen,
    # X-Permitted-Cross-Domain-Policies none).
    config.action_dispatch.default_headers.merge!(
      # Don't leak the full referrer URL to other origins.
      'Referrer-Policy' => 'strict-origin-when-cross-origin',
      # Disable powerful browser features this site never uses.
      'Permissions-Policy' => 'geolocation=(), camera=(), microphone=(), payment=(), usb=()',
      # Modern guidance (OWASP) is to disable the legacy XSS auditor rather than
      # enable it; CSP is the real XSS defense.
      'X-XSS-Protection' => '0'
    )
  end
end
