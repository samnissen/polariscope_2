task :sync_sibling_relationships => :environment do
  SiblingRelationshipSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_sibling_relationships do
  backup_queue_exists = Delayed::Job.where(queue: "sibling_relationships", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job for syncing sibling_relationships already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_sibling_relationships => :before_sync_sibling_relationships
