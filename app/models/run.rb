class Run < ActiveRecord::Base
  PERMITTED_OPERATIONS = /^[1-9]{1,2}\.(day|year|month|hour|minute|week)(s\.|\.)ago$/
  DEFAULT_DATERANGE = 6.months.ago

  serialize :test_ids
  serialize :browsers

  has_many :run_tests
  belongs_to :collection
  belongs_to :environment
  belongs_to :scheduled_test

  before_create :compile
  before_create :escape_jquery_html_characters
  after_create :add_run_context_to_name
  after_save :update_sendable_status
  before_save :do_not_update_completed_runs

  validates :test_ids, presence: true
  validates :environment, presence: true
  validates :browsers, presence: true

  # A test status that defaults to 'failed' if even one test failed
  def falsey_test_status
    test_statuses = self.run_tests.map{ |rt| rt.test_statuses.map{|ts| ts.success} }.flatten.uniq

    step_failed = test_statuses.include?(false)
    return { :class => 'false', :display => 'failed' } if step_failed

    still_running = test_statuses.include?(nil)
    return { :class => 'nil', :display => 'to run' } if still_running

    all_steps_passed = test_statuses.include?(true)
    return { :class => 'true', :display => 'passed' } if all_steps_passed

    return { :class => 'error', :display => 'something went wrong'}
  end

  private
    def self.dateify(rawmax)
      return DEFAULT_DATERANGE unless permit_eval?(rawmax)
      max = eval(rawmax)
      return DEFAULT_DATERANGE unless max.is_a?(ActiveSupport::TimeWithZone)

      max
    end

    def self.permit_eval?(operation)
      return !PERMITTED_OPERATIONS.match("#{operation}").nil?
    end

    def self.prune(rawmax)
      max = dateify(rawmax)
      olds = Run.where("created_at < ?", max)

      return true unless olds.size > 0

      olds.each(&:destroy!)
    end

    # Create the belonging data
    # by copying the existing testsets (tests is a resevered word in Rails),
    # which will copy the existing test_actions,
    # which will copy the existing object_identifiers, etc., etc.
    def compile
      self.test_ids.each do |tid|
        testset = Testset.find(tid)

        next unless testset.test_actions.any?
        next if runtest_duplicates_previous?(testset)

        self.run_tests.build({
          name: testset.name,
          description: testset.description,
          testset: testset,
          run: self
        })
      end
    end

    def runtest_duplicates_previous?(testset)
      return self.run_tests.map{ |rt|
        true if rt.testset == testset
      }.compact.first || false
    end

    def escape_jquery_html_characters
      self.name = CGI::unescapeHTML(self.name)
      self.description = CGI::unescapeHTML(self.description)
    end

    def add_run_context_to_name
      old_name = self.name

      self.update_attribute(:name, "A run of '#{old_name}'")
    end

    # Mark for collection by the API sender so that
    # a worker can pick it up from the API.
    # Just in case the cascade of creation takes a moment
    # to completely save and release the appropriate resources
    def update_sendable_status
      return true if self.ready_to_send.is_a?(TrueClass)
      self.update_attribute(:ready_to_send, true)
    end
    handle_asynchronously :update_sendable_status, :run_at => Proc.new { 5.seconds.from_now }, :queue => 'runs'
end
