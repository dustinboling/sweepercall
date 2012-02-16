desc "This task finds all of the notifications that need to be sent and sends them"
task :check_notifications => :environment do 
  puts "Finding notifications for tomorrow..."

end

# Check if first, second, third or fourth day of week
# If none we return
def current_week(current_day, current_month)
  if Chronic.parse("1st #{current_day} in #{current_month}").strftime('%Y-%m-%d') == Time.now.strftime('%Y-%m-%d')
    current_week = "1st"
  elsif Chronic.parse("2st #{current_day} in #{current_month}").strftime('%Y-%m-%d') == Time.now.strftime('%Y-%m-%d')
    current_week = "2nd"
  elsif Chronic.parse("3rd #{current_day} in #{current_month}").strftime('%Y-%m-%d') == Time.now.strftime('%Y-%m-%d')
    current_week = "3rd"
  elsif Chronic.parse("4th #{current_day} in #{current_month}").strftime('%Y-%m-%d') == Time.now.strftime('%Y-%m-%d')
    current_week = "4th"
  else
    current_week = "nil"
  end
end

day = Time.now.strftime('%A').downcase
month = Time.now.strftime('%B').downcase

# This is when to run the task.
today = Chronic.parse("#{current_week(day, month)} #{current_day} in #{current_month}")

def mail_me
  if today.nil?
    # Do not run task
  else
    # Run task
end




# Get a list of all notifications happening today.
@notifications = Notification.where("week = '1st' AND day = 'Wednesday'").collect { |n| n.person_id }
@notifications.each do |notification|
  