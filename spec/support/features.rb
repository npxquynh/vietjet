# spec/support/features.rb

require "#{Rails.root}/spec/support/features/place_helpers.rb"

# Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Features::PlaceHelpers
end
