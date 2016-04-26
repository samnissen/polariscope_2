class ValidTestDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ((1.hour.ago.to_datetime)..(3.months.from_now.to_datetime)).cover?("#{value}".to_datetime)
      puts "\n"
      puts "\n---->\t((1.hour.ago.to_datetime)..(3.months.from_now.to_datetime)).include?(value)"
      puts "\n---->\t((#{1.hour.ago.to_datetime})..(#{3.months.from_now.to_datetime})).include?(#{value})"
      puts "\n---->\t(#{(1.hour.ago.to_datetime)..(3.months.from_now.to_datetime)}).include?(value)"
      puts "\n---->\t#{((1.hour.ago.to_datetime)..(3.months.from_now.to_datetime)).include?(value)}"
      puts "\n\n"
      record.errors[attribute] << (options[:message] || "must be between now and three months from now #{value}")
    end
  end
end
