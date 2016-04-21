require 'time'

class Prune
  def initialize
    @log = Delayed::Worker.logger
  end

  def work
    run_range = ENV['POLARISCOPE_ALLOWED_RUN_DATE_RANGE']

    @log.debug("Removing any Runs older than '#{run_range}'.")

    Run.prune(run_range)

    schedule_next_backup_job
  end

  def schedule_next_backup_job
    work
  end

  handle_asynchronously :schedule_next_backup_job, :run_at => Proc.new { 24.hours.from_now }, :queue => 'queue'
end
