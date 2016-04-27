class ScheduledTest < ActiveRecord::Base
  serialize :test_ids
  serialize :browser_ids

  belongs_to :user

  validates :test_ids, presence: true
  validates :recurring, presence: true

  # Custom validator
  # Is the date provided after now and
  # is it within the next 6 months
  validates :next_test, presence: true, valid_test_date: true

  before_save :tests_exist
  before_save :browsers_exist

  after_save :remove_deleted_tests
  after_save :remove_deleted_browsers

  after_save :deduplicate_tests
  after_save :deduplicate_browsers

  after_create :schedule_next_test

  def next_test=(date)
   begin
     parsed = DateTime.strptime(date, '%Y-%d-%m %H:%M:%S %Z')
     super parsed
   rescue
     date
   end
  end

  def tests_exist
    has_existing_tests = Array(test_ids).map { |tid|
      true if Testset.find_by(:id => tid).present?
    }.compact.first

    errors.add(:base, "Please add at least one test that exists") unless has_existing_tests
  end

  def remove_deleted_tests
    filtered_ids = Array(test_ids).map { |tid|
      nil unless Testset.find_by(:id => tid).present?
      tid
    }.compact

    return nil unless filtered_ids

    self.update_column(:test_ids, filtered_ids)
  end

  def deduplicate_tests
    self.update_column(:test_ids, test_ids.uniq)
  end

  def browsers_exist
    has_existing_tests = Array(browser_ids).map { |bid|
      true if BrowserType.find_by(:id => bid).present?
    }.compact.first

    errors.add(:base, "Please add at least one browser that exists") unless has_existing_tests
  end

  def remove_deleted_browsers
    filtered_ids = Array(browser_ids).map { |bid|
      nil unless BrowserType.find_by(:id => bid).present?
      bid
    }.compact

    return nil unless filtered_ids

    self.update_column(:browser_ids, filtered_ids)
  end

  def deduplicate_browsers
    self.update_column(:browser_ids, browser_ids.uniq)
  end

  def when_to_run
    puts "\n\n=====>\t#{self.inspect}\n\n"
    next_test
  end

  # An intentional infinite loop
  #
  ## create -> schedule_next_test  ##
  ##         /          /\         ##
  ##       \/            \         ##
  ## pop_off ---> set_when_to_run  ##
  ##   \                           ##
  ##   \/                          ##
  ##   Run.create                  ##

  def schedule_next_test
    delay(run_at: next_test).pop_off
  end

  def set_when_to_run
    self.update_column(:next_test, DateTime.utc.now + (recurring * 60 * 24))
  end

  def pop_off
    Run.create({
      collection: collection,
      test_ids: test_ids,
      browsers: browser_ids,
      environment: environment,
      name: collection.name,
      description: collection.description
    })

    set_when_to_run

    schedule_next_test
  end
  # handle_asynchronously :pop_off, :run_at => Proc.new { when_to_run }, :queue => 'scheduled_tests'

end
