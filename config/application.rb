require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Gumsnipp
  class Application < Rails::Application
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.time_zone = 'Warsaw'
    config.encoding = "utf-8"
  end
end
