
require 'cucumber/rails'

Capybara.default_selector = :css

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# Before do
#   require File.dirname(__FILE__) + '/seeds'
# end
# 
# After do
#   puts 'AFTER'
# end