class ScheduledTest < ActiveRecord::Base
  serialize :test_ids
  serialize :browser_ids

  belongs_to :user
  belongs_to :collection
  belongs_to :environment
  has_many :runs

  validates :test_ids, presence: true
  validates :recurring, presence: true
  validates :recurring, :inclusion => 1..365
  validates :environment, presence: true
  validates :collection, presence: true

  # Custom validator
  # Is the date provided after now and
  # is it within the next 6 months
  validates :next_test, presence: true, valid_test_date: true

  before_save :tests_exist
  before_save :browsers_exist

  after_save :set_collection_based_on_tests

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

  def set_collection_based_on_tests
    self.update_column(:collection_id, Testset.find(test_ids.first).collection.id)
  end

  def tests_exist
    has_existing_tests = Array(test_ids).map { |tid|
      true if Testset.find_by(:id => tid).present?
    }.compact.first

    errors.add(:base, "Please add at least one test that exists") unless has_existing_tests
  end

  def remove_deleted_tests
    filtered_ids = Array(test_ids).map { |tid|
      tid if Testset.find_by(:id => tid).present?
    }.compact

    self.update_column(:test_ids, filtered_ids)
  end

  def deduplicate_tests
    self.update_column( :test_ids, test_ids.map{|tid| tid if Testset.find(tid).collection == self.collection }.compact.uniq )
  end

  def browsers_exist
    has_existing_tests = Array(browser_ids).map { |bid|
      true if BrowserType.find_by(:id => bid).present?
    }.compact.first

    errors.add(:base, "Please add at least one browser that exists") unless has_existing_tests
  end

  def remove_deleted_browsers
    filtered_ids = Array(browser_ids).map { |bid|
      bid if BrowserType.find_by(:id => bid).present?
    }.compact

    self.update_column(:browser_ids, filtered_ids)
  end

  def deduplicate_browsers
    self.update_column(:browser_ids, browser_ids.uniq)
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
    self.delay(:run_at => next_test, :queue => 'scheduled_tests').pop_off
  end

  def set_when_to_run
    self.update_column( :next_test, (DateTime.now.utc + recurring) )
  end

  def pop_off
    remove_deleted_tests
    remove_deleted_browsers

    Run.create!({
      collection: collection,
      test_ids: test_ids,
      browsers: browser_ids_to_keys,
      environment: environment,
      name: collection.name,
      description: collection.description,
      scheduled_test: self
    })

    if ( recurring && "#{recurring}".to_i > 0 )
      sleep(0.1); set_when_to_run

      sleep(0.1); schedule_next_test
    end
  end

  def browser_ids_to_keys
    browser_ids.map{ |bid| bt = BrowserType.find_by(:id => bid); bt.key }.compact
  end

  def last_run_status
    return { :class => 'error', :display => 'no tests'} unless Run.where(scheduled_test: self).any?

    run_tests = Run.where(scheduled_test: self).order("created_at ASC").first.run_tests
    test_statuses = run_tests.map{ |rt| rt.test_statuses.map{|ts| ts.success} }.flatten.uniq

    puts "test_statuses: #{test_statuses}"

    step_failed = test_statuses.include?(false)
    return { :class => 'false', :display => 'failed' } if step_failed

    still_running = test_statuses.include?(nil)
    return { :class => 'nil', :display => 'to run' } if still_running

    all_steps_passed = test_statuses.include?(true)
    return { :class => 'true', :display => 'passed' } if all_steps_passed
  end
end
