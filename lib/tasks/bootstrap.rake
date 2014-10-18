desc 'Load Dummy Data'
task bootstrap: %w[ bootstrap:recreate ]

namespace :bootstrap do

  desc 'load schema, seeds, and load dummy data'
  task load: %w[ db:schema:load db:seed bootstrap:data ]

  desc 'reset the database and load dummy data'
  task reset: %w[ db:schema:load db:seed bootstrap:data ]

  desc 'recreate the database and load dummy data'
  task recreate: %w[ db:migrate:reset db:seed bootstrap:data ]

  desc 'generate all bootstrap data'
  task :data do
    scope = Rake::Scope.new 'bootstrap:data'
    tasks = Rake.application.tasks_in_scope scope
    tasks.each &:invoke
  end

  task :test do
    Rake::Task[:environment].reenable
    Rake::Task[:environment].invoke
    Rake::Task['db:test:prepare'].invoke
  end

  namespace :data do

    desc 'create users with no roles'
    task users: %w[ environment ] do
      2.times.each do |n|
        User.where(email: "user#{ n }@testing.com").first_or_create do |user|
          user.password              = 'testing!'
          user.password_confirmation = 'testing!'
          user.skip_confirmation!
        end
      end
    end

  end

end
