#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Meeple::Application.load_tasks

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new do |task|
    task.options << '--auto-correct'
    task.formatters   = %w[ simple ]
  end

  task('spec').clear # remove default spec task
  RSpec::Core::RakeTask.new :spec => :rubocop
rescue LoadError
  puts 'Rubocop unavailable'
end
