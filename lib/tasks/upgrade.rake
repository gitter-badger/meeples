namespace :upgrade do
  desc 'run after deploy'
  task :latest => :environment do
    Play.find_each(&:save!)
  end
end
