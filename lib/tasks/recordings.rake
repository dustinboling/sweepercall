namespace :recordings do
  
  desc "sends out all the recordings for the day"
  task :call => :environment do
    call_me
  end
  
  desc "delete all recordings"
  task :delete => :environment do
    account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'

    puts "Connecting twilio client..."
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @account = @client.account
    
    puts "Finding all messages..."
    @recordings = @account.recordings
    
    puts "Deleting all messages..."
    @recordings.each do |recording|
      recording.delete
    end
    
    puts "Success!"
  end

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
  
  def call_me
    current_day = Time.now.strftime('%A').downcase
    current_month = Time.now.strftime('%B').downcase
    today = Chronic.parse("#{current_week(current_day, current_month)} #{current_day} in #{current_month}")
    
    if today.nil?
      puts "No voice notifications for today!"
    else
      @account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
      @auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
      @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      @account = @client.account
      
      @notifications = Notification.where("week = '#{current_week(current_day, current_month)}' AND day = '#{current_day}' AND notification_type = 3")
      @people = @notifications.collect { |person| Person.find_by_id(person.person_id) }
      @people.each do |p|
        if p.agent_id.nil?
          agent = Agent.find(12)
        else
          agent = Agent.find(p.agent_id)
        end
        person = Person.find(p.id)
        
        @call = @account.calls.create(
          :from => '19496129779',
          :to => "#{person.phone}",
          :url => 'http://sweepercall.heroku.com/recordings/notification.xml',
          :method => "GET"
        )        
      end
    end  
  end
  
end