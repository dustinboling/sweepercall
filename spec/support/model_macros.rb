module ModelMacros
  
  def current_week
    current_day = Time.now.strftime('%A').downcase
    current_month = Time.now.strftime('%B').downcase
    @today = Time.now.strftime('%Y-%m-%d')

    if Chronic.parse("1st #{current_day} in #{current_month}").strftime('%Y-%m-%d') == @today
      current_week = "1st"
    elsif Chronic.parse("2nd #{current_day} in #{current_month}").strftime('%Y-%m-%d') == @today
      current_week = "2nd"
    elsif Chronic.parse("3rd #{current_day} in #{current_month}").strftime('%Y-%m-%d') == @today
      current_week = "3rd"
    elsif Chronic.parse("4th #{current_day} in #{current_month}").strftime('%Y-%m-%d') == @today
      current_week = "4th"
    else
      current_week = "nil"
    end
  end
  
  def day_iter(day)
    case day
    when 1
      @day = "monday"
    when 2
      @day = "tuesday"
    when 3
      @day = "wednesday"
    when 4
      @day = "thursday"
    when 5
      @day = "friday"
    when 6
      @day = "saturday"
    when 7
      @day = "sunday"
    end
  end
  
end