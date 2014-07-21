ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'rspec/autorun'
require 'simplecov'
SimpleCov.start 'rails'

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.include Capybara::DSL
  config.before :all do
    Rails.application.load_seed
  end
  config.after :all do
    ActiveRecord::Base.subclasses.each(&:delete_all)
  end
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers
end
