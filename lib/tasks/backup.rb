require 'time'

class Backup

  def initialize
    @log = Delayed::Worker.logger
  end

  def work
    start_an_automatic_backup

    sleep(5)

    schedule_next_backup_job
  end

  def start_an_automatic_backup
    begin
      @log.info("Start an automatic backup to the backend server at [#{Time.now}]")

      backup_yml    = YAML.load_file("#{Rails.root}/config/backup_credential.yml")
      database_yml  = YAML.load_file("#{Rails.root}/config/database.yml")

      backup_file_name    = backup_yml['backup']['backup_file_name']
      backup_file_folder  = backup_yml['backup']['backup_file_folder']
      backup_server_user  = backup_yml['backup']['ssh_username']
      backup_server_ip    = backup_yml['backup']['backup_server_ip']
      backup_server_path  = backup_yml['backup']['backup_server_path']
      mysql_username      = database_yml['production']['username']
      mysql_password      = database_yml['production']['password']
      mysql_database      = database_yml['production']['database']
      backup_file_path    = File.join("#{backup_file_folder}", "#{backup_file_name}")

      # Dump the database
      backup  = system("mysqldump -u#{mysql_username} -p#{mysql_password} #{mysql_database} > #{backup_file_path}")

      sleep(10)

      # https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
      # The -a option is a combination flag which stands for "archive"
      # The -v flag (for verbose) is also necessary to get the appropriate output
      # If you are transferring files that have not already been compressed, like text files,
        # you can reduce the network transfer by adding compression with the -z option
      # The -P flag is very helpful. It combines the flags --progress and --partial.
        # The first of these gives you a progress bar for the transfers and the second allows you to resume interrupted transfers
      results = system("rsync -avz -e \"ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null\" #{backup_file_path} #{backup_server_user}@#{backup_server_ip}:#{backup_server_path}")

      @log.info("Completed an automatic backup in the backend server at [#{Time.now}]")
      sleep(3)
    rescue => e
      @log.error("Error occured while getting DB Back-up at [#{Time.now}] - #{e.class}: #{e.message}")
      e.backtrace.each {|bt| @log.info("#{bt}")}
    end
  end

  def self.when_to_run
    # Execute DB backup everyday at 12:00 AM
    # example: m = Time.parse('00:00'); t = Time.parse('10:30'); (t.to_i - m.to_i)
      # => 37800
    hours = Time.parse('24:00')
    current_time_in_hours = Time.parse(Time.now.strftime("%H.%M"))
    execute_hours_in_seconds = (hours.to_i - current_time_in_hours.to_i)
    execute_hours_in_seconds.seconds.from_now
  end

  def schedule_next_backup_job
    back_up_nqa_database
  end

  # handle the job periodically at the interval of 24 hours
  # 1.day.from_now will be evaluated when back_up_nqa_database is called
  handle_asynchronously :schedule_next_backup_job, :run_at => Proc.new { when_to_run }, :queue => 'backup'
end
