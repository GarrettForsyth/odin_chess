require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OdinChess
  class Application < Rails::Application
    # Add images in emails
    config.action_mailer.asset_host = 'https://odin-chess.herokuapp.com'

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif *.svg]
  end
end
