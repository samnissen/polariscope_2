class Run < ActiveRecord::Base
  PERMITTED_OPERATIONS = /^[1-9]{1,2}\.(day|year|month|hour|minute)(s\.|\.)ago$/
  DEFAULT_DATERANGE = 6.months.ago

  serialize :test_ids
  serialize :browsers

  has_many :run_tests
  belongs_to :collection
  belongs_to :environment

  before_create :compile
  before_create :escape_jquery_html_characters
  after_create :add_run_context_to_name
  after_save :update_sendable_status

  validates :environment, presence: true
  validates :browsers, presence: true

  after_create do
    self.class.prune(ENV['POLARISCOPE_ALLOWED_RUN_DATE_RANGE'])
  end

  private
    def self.dateify(rawmax)
      return DEFAULT_DATERANGE unless permit_eval?(rawmax)
      max = eval(rawmax)
      return DEFAULT_DATERANGE unless max.class.is_a?(ActiveSupport::TimeWithZone)

      max
    end

    def permit_eval?(operation)
      return !PERMITTED_OPERATIONS.match("#{operation}").nil?
    end

    def self.prune(rawmax)
      max = dateify(rawmax)
      olds = Run.where("created_at < ?", max).size

      return true unless olds > 0

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

        self.run_tests.build({
          name: testset.name,
          description: testset.description,
          testset: testset,
          run: self
        })
      end
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
      self.update_attribute(:ready_to_send, true)
    end
    handle_asynchronously :update_sendable_status, :run_at => Proc.new { 5.seconds.from_now }

end
