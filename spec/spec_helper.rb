require 'active_model'
require 'factory_girl_rails'
require 'ruby-try'
require 'validates_type'

Dir[File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib', '**', '*.rb')].each do |fp|
  load fp
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include FactoryGirl::Syntax::Methods

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
