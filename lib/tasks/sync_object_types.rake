task :sync_object_types => :environment do
  ObjectTypeSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_object_types do
  backup_queue_exists = Delayed::Job.where(queue: "object_types", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job for syncing object_types already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_object_types => :before_sync_object_types
