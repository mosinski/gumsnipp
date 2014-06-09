ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'rspec/autorun'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  config.include Capybara::DSL
  config.after :all do
    ActiveRecord::Base.subclasses.each(&:delete_all)
  end
end
