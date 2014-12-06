source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails'

gem 'activeadmin',    github: 'gregbell/active_admin'
gem 'cancancan'
gem 'devise'
gem 'haml-rails'
gem 'hirb'
gem 'hiredis'
gem 'jquery-rails'
gem 'nokogiri'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'pg'
gem 'pry-rails'
gem 'rails4-autocomplete'
gem 'redcarpet'
gem 'redis'
gem 'sass-rails'
gem 'simple_form', '~> 3.1.0.rc1'

group :assets do
  gem 'coffee-rails'
  gem 'jquery-ui-rails'
  gem 'uglifier'
end

group :production, :staging do
  gem 'dalli'
  gem 'memcachier'
  gem 'newrelic_rpm'
  gem 'rack-attack'
  gem 'rails_12factor'
  gem 'rollbar',               '~> 1.0.0'
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
  gem 'faker'
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
  gem 'vcr'
  gem 'webmock'
end
