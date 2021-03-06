source 'https://rubygems.org'

ruby '2.2.2'

gem 'rails', '~> 4.2.0'

gem 'cancancan'
gem 'devise'
gem 'haml-rails'
gem 'hirb'
gem 'hiredis'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'nokogiri'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'pg'
gem 'pry-rails'
gem 'rails4-autocomplete'
gem 'redis'
gem 'responders'
gem 'sass-rails'
gem 'simple_form'

group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production, :staging do
  gem 'dalli'
  gem 'memcachier'
  gem 'newrelic_rpm'
  gem 'rack-attack'
  gem 'rack-canonical-host'
  gem 'rails_12factor'
  gem 'rollbar'
  gem 'unicorn'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'pry-byebug'
  gem 'pry-doc'

  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop',       require: false, git: 'https://github.com/bbatsov/rubocop.git'
  gem 'rubocop-rspec', require: false
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
