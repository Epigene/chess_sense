require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module ChessSense
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec
      g.factory_bot dir: "spec/factories"
      g.template_engine = false
      g.assets = false
      g.helper = false
    end

    config.time_zone = 'Riga'

    config.filter_parameters += [:password]

    config.autoload_paths += %W(#{config.root}/app/controllers/**/*.rb)
    config.autoload_paths += %W(#{config.root}/app/models/**/*.rb)
    config.autoload_paths += %W(#{config.root}/app/services/**/*.rb)

    config.i18n.fallbacks = false
    config.i18n.available_locales = [:en]
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir["#{Rails.root}/config/locales/**/*.yml"]
  end
end
