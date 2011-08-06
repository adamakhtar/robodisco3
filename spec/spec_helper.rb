# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
require 'vcr'

require 'user_helper'

#VCR gem description - 
#Record your test suite's HTTP interactions and replay them during 
#future test runs for fast, deterministic, accurate tests.
VCR.config do |c|
  c.ignore_localhost = true
  c.cassette_library_dir     = 'spec/cassettes'
  c.stub_with                :fakeweb
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.extend VCR::RSpec::Macros

  #configure rspec to use database cleaner gem
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false #set to false for database_cleaner

  config.before(:suite) do  
    DatabaseCleaner.strategy = :truncation  
  end  
    
  config.before(:each) do  
    DatabaseCleaner.start  
  end  
    
  config.after(:each) do  
    DatabaseCleaner.clean  
  end  
end
