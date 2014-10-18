source 'https://rubygems.org'

gem 'rails'

gem 'activeadmin',    github: 'gregbell/active_admin'
gem 'bootstrap-sass'
gem 'cancan'
gem 'devise'
gem 'haml-rails'
gem 'hirb'
gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'pg'
gem 'pry-rails'
gem 'redcarpet'
gem 'sass-rails'

group :assets do
  gem 'coffee-rails'
  gem 'jquery-ui-rails'
  gem 'uglifier'
end

group :production do
  gem 'dalli'
  gem 'memcachier'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
  gem 'unicorn'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-its'
  gem 'syntax'
  gem 'timecop'
  gem 'validation_matcher'

  # alternative DBs for CI
  gem 'mysql2'
  gem 'sqlite3'
end
