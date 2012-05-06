
require 'cucumber/rails'

Capybara.default_selector = :css

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  require File.dirname(__FILE__) + '/seeds'
end

# 
# Before do
#   ActiveRecord::Fixtures.reset_cache
#   fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
#   fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
#   ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
# end
# 
# # Sets up the Rails environment for Cucumber
# ENV["RAILS_ENV"] = "test"
# require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
# require 'cucumber/rails/world'
# Cucumber::Rails::World.use_transactional_fixtures
# 
# #Seed the DB
# ActiveRecord::Fixtures.reset_cache
# fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
# fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
# ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
# 
# Cucumber::Rails::Database.javascript_strategy = :truncation
