# Settingslogic config, needed by other initializers (devise, rollbar), so it
# can't be autoloaded from app/ (Rails 7 forbids autoloading during boot).
require Rails.root.join('lib/setting').to_s
