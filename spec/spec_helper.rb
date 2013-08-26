ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'

# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome

Capybara.app_host = 'http://www.google.com'

Dir[Rails.root.join("spec/support/*.rb")].each {|f| require f}
