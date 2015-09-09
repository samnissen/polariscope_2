task :sync_selectors => :environment do
  SelectorSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_selectors do
  backup_queue_exists = Delayed::Job.where(queue: "selectors", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job for syncing id_types already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_selectors => :before_sync_selectors
