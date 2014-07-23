require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Gumsnipp
  class Application < Rails::Application
    config.after_initialize do
      Disqus::defaults[:account] = 'Gumsnipp'
      Disqus::defaults[:developer] = true
      Disqus::defaults[:container_id] = "disqus_thread"
      Disqus::defaults[:show_powered_by] = false
    end
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.assets.initialize_on_precompile = false
    config.assets.version = '1.0'
    config.assets.enabled = true
    config.time_zone = 'Warsaw'
    config.encoding = "utf-8"
  end
end
