task :queue_runs => :environment do
  QueueRun.new.work
end

# jobs queue for backup, with protection
task :before_queue_runs do
  run_queue_exists = Delayed::Job.where(queue: "runs", failed_at: nil).exists?
  if run_queue_exists
    # abort the rake task
    abort("Job for syncing runs already exists!")
  end
end

# protect your job queue before getting the fraud match
task :queue_runs => :before_queue_runs
