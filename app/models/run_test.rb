class RunTest < ActiveRecord::Base
  belongs_to :run
  belongs_to :testset
  has_many :run_test_actions
  has_many :test_statuses

  before_save :compile
  before_create :escape_jquery_html_characters

  private
    def compile
      compile_test_actions
      compile_test_statuses
    end

    def compile_test_actions
      self.testset.test_actions.each do |test_action|
        self.run_test_actions.build({
          name: test_action.name,
          description: test_action.description,
          activity: test_action.activity,
          test_action: test_action,
          run_test: self
        })
      end
    end

    def compile_test_statuses
      self.run.browsers.each do |browser_key|
        self.test_statuses.build({
          run_test: self,
          browser_type: BrowserType.where(:key => browser_key).first
        })
      end
    end

    def escape_jquery_html_characters
      self.name = CGI::unescapeHTML(self.name)
      self.description = CGI::unescapeHTML(self.description)
    end
end
