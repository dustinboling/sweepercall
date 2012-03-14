# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create some users for agent # 12
# change agent_id to whatever your development agent is.
# NOTE: this does not create user accounts along with the people
# 100.times do 
#   Person.create(:first_name => Faker::Name::first_name, 
#     :last_name => Faker::Name::last_name, 
#     :address => Faker::Address::street_address(include_secondary = false),
#     :city => Faker::Address::city,
#     :state => Faker::Address::state,
#     :zip => Faker::Address::zip_code, 
#     :agent_id => 12, 
#     :phone => "7145122526")
# end

# This one is for ongoing testing of the system.
# It creates 7 people, 1 for each day of the week. 
# Each person should have one notification of each type for the 1st/2nd/3rd/4th/5th of each month.
# Once set up you should be recieving one of each type of notificaiton
# to your phone, mobile phone, each day of the week, and each week of the month.
# *** This does not create a user account, only people and notifications for them (can't log in as them) ***
# *** Set Agent_id to whatever the MASTER agent_id is for your environment ***

day = 1
while day <= 7
  
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
  
  @person = Person.create(:first_name => @day.capitalize,
    :last_name => "TESTER", 
    :address => Faker::Address::street_address(include_secondary = false),
    :city => Faker::Address::city,
    :state => Faker::Address::state,
    :zip => Faker::Address::zip_code,
    :agent_id => 12, 
    :phone => "7145122526",
    :mobile_phone => "7145122526",
    :email => "test#{day}@dustinboling.com"
    )
  @person_id = @person.id
  
  week = 1
  while week <= 4
    
    case week
    when 1
      @week = "1st"
    when 2
      @week = "2nd"
    when 3
      @week = "3rd"
    when 4
      @week = "4th"
    end
    
    Notification.create(:day => @day,
      :week => @week,
      :person_id => @person.id,
      :notification_type => 1
    )
    Notification.create(:day => @day,
      :week => @week,
      :person_id => @person.id,
      :notification_type => 2
    )
    Notification.create(:day => @day,
      :week => @week, 
      :person_id => @person.id,
      :notification_type => 3
    )
    
    week = week + 1
  end
  
  day = day + 1
end