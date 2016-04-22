class RunObjectIdentifier < ActiveRecord::Base
  belongs_to :run_test_action
  belongs_to :user

  has_many :run_object_identifier_siblings
  has_many :run_test_action_data

  belongs_to :object_type
  belongs_to :selector
  belongs_to :object_identifier

  before_save :compile

  def placeholder?
    (self.object_type.type_name == "n/a") && (self.selector.selector_name == "n/a") && (self.identifier == "null")
  end

  def has_data?
    self.run_test_action_data.size > 0 && ("#{self.run_test_action_data.first.data}".length > 0)
  end

  def has_data_or_object?
    has_data? || !placeholder?
  end

  private
    def compile
      compile_siblings

      compile_data
    end

    def compile_siblings
      self.object_identifier.object_identifier_siblings.each do |sibling|
        self.run_object_identifier_siblings.build({
          identifier: sibling.identifier,
          object_type: sibling.object_type,
          selector: sibling.selector,
          sibling_relationship: sibling.sibling_relationship,
          object_identifier_sibling: sibling,
          run_object_identifier: self
        })
      end
    end

    def compile_data
      self.object_identifier.test_action_data.each do |tadata|
        data_to_use = nil

        if tadata.data_element
          environment = self.run_test_action.run_test.run.environment
          variable = tadata.data_element.data_element_values.where(environment: environment).first

          if variable.random_value
            # OK so this is a bit of weird one.
            # SecureRandom is the preferred way to generate random values.
            # (see: http://stackoverflow.com/a/1619602/1651458)
            # But hex only produces even-length strings.
            # So, hex(8) produces a 16-character string,
            # hex(9) an 18-character string.
            # In order to produce an odd-length string, we must produce
            # strings that are too long, and slice off the unnecessary bits.
            data_to_use = "#{SecureRandom.hex((variable.random_value_length/2)+1)}"[0..(variable.random_value_length-1)]
            is_encrypted = false
          else
            data_to_use = variable.encrypted_value
            is_encrypted = true
          end


        else
          data_to_use = tadata.data
          is_encrypted = false
        end

        self.run_test_action_data.build({
          data: data_to_use,
          test_action_datum: tadata,
          run_object_identifier: self,
          encrypted: is_encrypted
        })
      end
    end
end
