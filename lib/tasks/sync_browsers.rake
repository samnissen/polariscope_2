task :sync_actions => :environment do
  ActionSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_actions do
  backup_queue_exists = Delayed::Job.where(queue: "actions", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job for syncing actions already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_actions => :before_sync_actions
