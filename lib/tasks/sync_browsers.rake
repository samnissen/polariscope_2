task :sync_browsers => :environment do
  BrowserSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_browsers do
  backup_queue_exists = Delayed::Job.where(queue: "browsers", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job for syncing browsers already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_browsers => :before_sync_browsers
