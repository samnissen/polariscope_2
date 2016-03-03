# task to take a DB backup
task :backup => :environment do
  Backup.new.work
end

# jobs queue for backup, with protection
task :before_backup do
  backup_queue_exists = Delayed::Job.where(queue: "backup", failed_at: nil).exists?
  if backup_queue_exists
    # abort the rake task
    abort("Job Queue for backing up the database already exists!")
  end
end

# protect your job queue before getting the fraud match
task :backup => :before_backup
