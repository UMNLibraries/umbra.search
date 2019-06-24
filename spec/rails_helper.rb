# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
require 'spec_helper'
require 'devise'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

#### CAPYBARA / SELENIUM
# Capybara config with docker-compose environment vars
require 'capybara/rails'
require 'capybara/rspec'
Capybara.app_host = "http://#{ENV['TEST_APP_HOST']}:#{ENV['TEST_PORT']}"
Capybara.javascript_driver = :selenium
Capybara.run_server = false

# Configure the Chrome driver capabilities & register
args = ['--no-default-browser-check', '--start-maximized', '--disable-gpu']
caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => args})
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
      desired_capabilities: caps
  )
end

require 'webmock/rspec'
WebMock.allow_net_connect!

require "support/features/sign_in"
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  # Make the Capybara DSL available in all integration tests
  config.include Capybara::DSL, :type => :feature

  # Fake it for SearchContextHelper::uri
  config.before :each do |test|
    if test.metadata[:type] == :view
      allow_any_instance_of(ActionController::TestRequest).to receive(:original_url).and_return('')
    end
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.include Features::SignIn, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

end
