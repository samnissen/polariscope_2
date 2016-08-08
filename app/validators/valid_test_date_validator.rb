class ValidTestDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ((1.hour.ago.to_datetime.utc)..(3.months.from_now.to_datetime.utc)).cover?("#{value}".to_datetime.utc)
      record.errors[attribute] << (options[:message] || "of #{value} must be between now and three months from now")
    end
  end
end
