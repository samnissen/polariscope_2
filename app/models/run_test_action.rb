class RunTestAction < ActiveRecord::Base
  belongs_to :test_action
  belongs_to :run_test
  belongs_to :activity

  has_one :run_object_identifier
  has_one :run_test_action_datum
  has_many :action_statuses

  before_save :compile

  private
    def compile
      compile_action_statuses
      compile_object_identifiers
    end

    def compile_object_identifiers
      oi = self.test_action.object_identifier

      return true unless oi

      self.build_run_object_identifier({
        identifier: oi.identifier,
        object_type: oi.object_type,
        selector: oi.selector,
        object_identifier: oi,
        run_test_action: self
      })
    end

    def compile_action_statuses
      self.run_test.run.browsers.each do |browser_key|
        self.action_statuses.build({
          run_test_action: self,
          browser_type: BrowserType.where(:key => browser_key).first
        })
      end
    end
end
