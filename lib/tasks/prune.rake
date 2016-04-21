# task to take a DB backup
task :prune => :environment do
  Prune.new.work
end

# jobs queue for backup, with protection
task :before_prune do
  prune_queue_exists = Delayed::Job.where(queue: "prune").exists?
  if prune_queue_exists # abort the rake task
    abort("Job Queue for pruning the database already exists!")
  end
end

# protect your job queue before getting the fraud match
task :prune => :before_prune
