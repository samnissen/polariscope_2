task :schedule_scheduled_tests => :environment do
  ScheduleScheduledTests.new.work
end

# jobs queue for backup, with protection
task :before_schedule_scheduled_tests do
  scheduled_test_are_queued = Delayed::Job.where(queue: "scheduled_tests").exists?
  if scheduled_test_are_queued
    # abort the rake task
    abort("Job for scheduling scheduled tests already exists!")
  end
end

# protect your job queue before re-scheduling scheduled test
task :schedule_scheduled_tests => :before_schedule_scheduled_tests
