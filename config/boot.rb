ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Rails < 7.1 relies on Logger being loaded already; concurrent-ruby >= 1.3.5 no longer does it.
require 'logger'
