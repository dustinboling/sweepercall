namespace :cron do
  
  current_day = Time.now.strftime('%A').downcase
  current_month = Time.now.strftime('%B').downcase
  
  desc "Find week of the month"
  task :check_time => :environment do
    puts "Figuring what week of the month it is..."
  end
  
  desc "Find notifications and send"
  task :check_notifications => :environment do
    puts "Querying database for today's notifications..."
    
  end
  
  desc "Send notifications for today"
  task :send_notifications => :environment do
    puts "Sending today's notifications..."
    mail_me
  end
  
  desc "All the notifications stuff!"
  task :notifications => [:check_time, :check_notifications, :send_notifications] do
    puts "Success!"
  end
  
  def current_week(current_day, current_month)
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

  def mail_me
    current_day = Time.now.strftime('%A').downcase
    current_month = Time.now.strftime('%B').downcase
    today = Chronic.parse("#{current_week(current_day, current_month)} #{current_day} in #{current_month}")
    
    if today.nil?
      puts "No notifications for today!"
    else
      @notifications = Notification.where("week = '#{current_week(current_day, current_month)}' AND day = '#{current_day}' AND notification_type = 1").collect { |n| User.find_by_id(Person.find_by_id(n.person_id).user_id).email }
      @notifications.each do 
        
    end
  end
  
end