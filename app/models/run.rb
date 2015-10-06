class Run < ActiveRecord::Base
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

  private
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
