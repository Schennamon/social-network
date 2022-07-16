require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require "active_job/railtie"
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api

  class Application < Rails::Application

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # config.time_zone = "Central Time (US & Canada)"
    # config.active_record.default_timezone = :local
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths << Rails.root.join('app/workers')
    config.autoload_paths << Rails.root.join('lib')

    config.action_mailer.preview_path = Rails.root.join('spec/mailers/previews')

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.application.credentials[:application_url]
        resource '*', headers: :any, methods: %i[get post put patch delete options head]
      end

      if Rails.env.development? || Rails.env.staging?
        allow do
          origins '*'
          resource '*', headers: :any, methods: %i[get post put patch delete options head]
        end
      end
    end

  end

end
