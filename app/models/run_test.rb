class RunTest < ActiveRecord::Base
  belongs_to :run
  belongs_to :testset
  has_many :run_test_actions
  has_many :test_statuses

  before_save :compile
  before_create :escape_jquery_html_characters

  def screenshots(browser_type_id)
    RunTestAction.where(run_test: self).map{|rta|
      rta.action_statuses.where(browser_type_id: browser_type_id).map{|as| as.screenshot}.compact
    }.compact #=> [['a1', 'b2', 'c3']]
  end

  def screenshot_count(browser_type_id)
    imagearray = screenshots(browser_type_id)
    imagearray = imagearray.reject { |c| c.empty? } #trim blanks from array
    imagearray.count
  rescue NoMethodError
    return 0
  end


  private
    def compile
      compile_test_actions
      compile_test_statuses
    end

    def compile_test_actions
      logger.debug "Compiling test actions for: #{self.testset.inspect} which has test_actions: #{self.testset.test_actions.inspect}"

      self.testset.test_actions.each do |test_action|
        logger.debug "test_action.pointer? #{test_action.pointer?} for #{test_action.inspect}"
        if test_action.pointer
          build_actions_from_pointer(test_action.pointer)
        else
          build_actions_without_pointer(test_action)
        end
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

    def build_actions_from_pointer(pointer)
      logger.debug "Building run_test_actions from a pointer: #{pointer}"
      logger.debug "Testset.where(id: pointer) is #{Testset.where(id: pointer).inspect}"

      Testset.where(id: pointer).first.test_actions.each do |test_action|
        self.run_test_actions.build({
          name: test_action.name,
          description: test_action.description,
          activity: test_action.activity,
          test_action: test_action,
          run_test: self
        })
      end
    end

    def build_actions_without_pointer(test_action)
      self.run_test_actions.build({
        name: test_action.name,
        description: test_action.description,
        activity: test_action.activity,
        test_action: test_action,
        run_test: self
      })
    end

    def escape_jquery_html_characters
      self.name = CGI::unescapeHTML(self.name) if self.name
      self.description = CGI::unescapeHTML(self.description) if self.description
    end

end
