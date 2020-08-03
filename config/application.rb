require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AdminGoldenowlAsia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    if Rails.env.test? || Rails.env.development?
      config.paperclip_defaults = {
        storage: :fog,
        fog_credentials: {
          provider: 'Local',
          default_url: '/images/:style/missing.png',
          local_root: "#{Rails.root}/public"
        },
        fog_directory: '',
        fog_host: ''
      }
    else
      config.paperclip_defaults = {
        storage: :cloudinary,
        path: ':class/:attachment/:id/:style/:filename'
      }
    end
  end
end
