task :sync_did_you_means => :environment do
  DidYouMeanTypeSync.new.work
end

# jobs queue for backup, with protection
task :before_sync_did_you_means do
  did_you_means_queue_exists = Delayed::Job.where(queue: "did_you_mean_types").exists?
  if did_you_means_queue_exists
    abort("Job for syncing did_you_mean_types already exists!")
  end
end

# protect your job queue before getting the fraud match
task :sync_did_you_means => :before_sync_did_you_means
