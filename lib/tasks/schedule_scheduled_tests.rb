class ScheduleScheduledTests
  def initialize
    fix_skipped_tests
  end

  def work
    get_outstanding_tests.each do |t|
      t.schedule_next_test
    end
  end

  def get_outstanding_tests
    ScheduledTest.where('next_test >= ?', DateTime.now)
  end

  def fix_skipped_tests
    fix_recurring_tests_in_the_past
    fix_not_run_past_tests
  end

  def fix_recurring_tests_in_the_past
    reset_run_time(get_out_of_order_tests)
  end

  def fix_not_run_past_tests
    reset_run_time(get_not_run_tests)
  end

  def get_out_of_order_tests
    ScheduledTest.where('next_test < ?', DateTime.now).where.not(:recurring => nil)
  end

  def get_not_run_tests
    ScheduledTest.where('next_test < ?', DateTime.now).map {|t| t unless t.runs.any? }.uniq.compact
  end

  def reset_run_time(tests)
    tests.each do |t|
      time = (DateTime.now.utc + 0.01)
      puts "giving #{time.inspect} for #{t.inspect}"
      t.next_test = time
      t.save!
    end
  end
end
