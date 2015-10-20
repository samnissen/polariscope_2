namespace :all do
  task :start do
    path = Rails.root.join('tmp', 'pids', 'delayed_job*.pid')
    msg = "DelayedJobs is already running.\n Run rake jobs:stop before proceeding."
    raise msg if Dir.glob(path).map { |rf| rf }.any?

    puts "Starting rake tasks..."; sleep(0.1)
    `rake sync_actions`
    `rake sync_selectors`
    `rake sync_sibling_relationships`
    `rake sync_object_types`
    `rake queue_runs`

    puts "Tasks started. Starting DelayedJobs workers..."; sleep(0.1)
    `RAILS_ENV=#{Rails.env} bin/delayed_job --queues=actions,selectors,sibling_relationships,object_types -i=1 start`
    `RAILS_ENV=#{Rails.env} bin/delayed_job --queue=runs -i=2 start`
    puts "DelayedJobs workers started."; sleep(0.1)
  end

  task :stop do
    puts "Stopping DelayedJobs workers..."; sleep(0.1)
    `RAILS_ENV=#{Rails.env} bin/delayed_job --queues=actions,selectors,sibling_relationships,object_types -i=1 stop`
    `RAILS_ENV=#{Rails.env} bin/delayed_job --queue=runs -i=2 stop`
    puts "DelayedJobs workers stopped."; sleep(0.1)
  end

  task :clear do
    puts "Are you sure you want to clear the existing jobs?"; sleep(0.1)
    print " > "
    response = STDIN.gets.chomp

    until ['Yes', 'no'].include?(response)
      puts "'Yes' or 'no'"; sleep(0.1)
      response = STDIN.gets.chomp
    end

    unless response == 'Yes'
      puts 'Aborting...'; sleep(0.1)
      return false
    end

    `RAILS_ENV=#{Rails.env} rake jobs:clear`
    puts "Jobs cleared."; sleep(0.1)
  end
end
