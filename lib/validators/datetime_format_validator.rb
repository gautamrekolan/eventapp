class DatetimeFormatValidator < ActiveModel::EachValidator 
  def validate_each(object, attribute, value)
     begin 
        dt = DateTime.parse(value)
      rescue
        # add error to 
        object.errors[attribute] << (options[:message] || "date / time invalid")
      end
  end
end