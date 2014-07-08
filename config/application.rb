require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module So
  class Application < Rails::Application
   
    config.generators do |g|
        g.test_framework :rspec, 
                         fixtures: true,
                         view_spec: false,
                         helper_specs: false,
                         routing_specs: false,
                         request_specs: false,
                         controller_spec: true
        g.fixture_replacment :factory_girl, dir: 'spec/factories'
        g.template_engine    :slim

        config.autoload_paths << Rails.root.join('lib/middleware')

        config.middleware.insert_after Rack::Runtime, 'DailyRateLimit' unless Rails.env.test?
    end
  end
end
