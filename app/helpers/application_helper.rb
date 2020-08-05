module ApplicationHelper
  def convert_ckeditor string
    return string.to_s.html_safe
  end

  def format created_at
      return created_at.strftime("%d-%m-%Y")
  end
  def format_day day
      return day.strftime("%d")
  end
  # // 2020-08-01
  def format_calendar_date date
      return date.strftime("%Y-%m-%d")
  end

  def format_datetime timer
    if timer.nil?
      return "00:00:0000 0:0"
    else
      return timer.strftime("%d-%m-%Y %H:%M")
    end
  end

  def formatsettime string
    return string.strftime(" %H:%M %d-%m-%Y")
  end

  def number_to_currency_br(number)
    unit =  number_to_currency(number, unit: "VNĐ", separator: "," , delimiter: ".")
    subunit = unit.gsub! 'VNĐ', " "
    return subunit
  end

  def get_current_date
     return Time.zone.now.to_date
  end
end
