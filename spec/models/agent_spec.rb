require 'spec_helper'

describe Agent do
  
  it "has a valid factory" do
    Factory.build(:agent).should be_valid
  end

  it "belongs to user" do
    a = Agent.reflect_on_association(:user)
    a.macro.should eq(:belongs_to)
  end
  
  it "has many recordings" do
    a = Agent.reflect_on_association(:recordings)
    a.macro.should eq(:has_many)
  end
  
  it "has many email notifications" do
    a = Agent.reflect_on_association(:email_notifications)
    a.macro.should eq(:has_many)
  end
  
  it "has many sms notifications" do 
    a = Agent.reflect_on_association(:sms_notifications)
    a.macro.should eq(:has_many)
  end
  
  it "should require a first name" do
    Factory.build(:agent, :first_name => "").should_not be_valid
  end  
  
  it "should require a last name" do
    Factory.build(:agent, :last_name => "").should_not be_valid
  end
  
  it "should require a phone number" do
    Factory.build(:agent, :outgoing_phone => "").should_not be_valid
  end 
  
  it "should only accept valid outgoing_phone numbers" do
    # valid examples
    Factory.build(:agent, :outgoing_phone => "7145122526").should be_valid
    Factory.build(:agent, :outgoing_phone => "17145122526").should be_valid
    Factory.build(:agent, :outgoing_phone => "1 (714) 5122526").should be_valid
    Factory.build(:agent, :outgoing_phone => "1 (714) 512-2526").should be_valid
    Factory.build(:agent, :outgoing_phone => "1-714-512-2526").should be_valid
    
    # invalid examples
    Factory.build(:agent, :outgoing_phone => "145122526").should_not be_valid
    Factory.build(:agent, :outgoing_phone => "71451225266").should_not be_valid
    Factory.build(:agent, :outgoing_phone => "171451225266").should_not be_valid
    Factory.build(:agent, :outgoing_phone => "1145122526").should_not be_valid
  end
  
  it "should only accept valid emails" do
    # valid
    Factory.build(:agent, :outgoing_email => "alan@dustinboling.com").should be_valid
    
    # not valid
    Factory.build(:agent, :outgoing_email => "alandustinboling.com").should_not be_valid
    Factory.build(:agent, :outgoing_email => "alan@dustinbolingcom").should_not be_valid
    Factory.build(:agent, :outgoing_email => "alan@dustinboling.com2").should_not be_valid
    Factory.build(:agent, :outgoing_email => "alandustinbolingcom").should_not be_valid
  end 
  
  it "should not allow more than one voice notification to be active at once" do
    @agent = Factory.build(:agent)
    @agent.save
    
    @agent.recordings.create(:active => true)
    @agent.recordings.create(:active => true)
    @agent.should_not be_valid
  end
  
  it "should allow a maximum of one sms notification to be active at once" do
    @agent = Factory.build(:agent)
    @agent.save
    
    @agent.sms_notifications.create(:active => true)
    @agent.sms_notifications.create(:active => true)
    @agent.should_not be_valid
  end
  
  it "should allow a maximum of one email notification to be active at once" do
    @agent = Factory.build(:agent)
    @agent.save
    
    @agent.email_notifications.create(:active => true)
    @agent.email_notifications.create(:active => true)
    @agent.should_not be_valid
  end 
  
  it "should set uuid before create" do
    @agent = Factory.build(:agent)
    @agent.save
    @agent.uuid.should eq(Digest::MD5.hexdigest("#{@agent.user_id}" + "#{@agent.first_name}" + "#{@agent.last_name}"))
  end
  
  it "should count the number of addresses an agent is serving" do
    @agent = Factory.build(:agent)
    @agent.save
    @person1 = Factory.build(:person, :agent_id => @agent.id)
    @person1.save
    @person2 = Factory.build(:person, :agent_id => @agent.id)
    @person2.save
    @person3 = Factory.build(:person, :agent_id => @agent.id)
    @person3.save
     
    @agent.count_addresses.should eq(3)
  end
  
  it "should count the number of unique zip codes an agent is serving" do
    @agent = Factory.build(:agent)
    @agent.save
    @person1 = Factory.build(:person, :zip => "92867", :agent_id => @agent.id)
    @person1.save
    @person2 = Factory.build(:person, :zip => "92660", :agent_id => @agent.id)
    @person2.save
    @person3 = Factory.build(:person, :zip => "92660", :agent_id => @agent.id)
    @person3.save
    
    @agent.count_neighborhoods.should eq(2)
  end
  
  it "should count the number of people who were notified for the agent today" do
    @agent = Factory(:agent)
    @agent.save
    @person = Factory(:person, :agent_id => @agent.id)
    @person.save
    @notification = Factory(:notification, 
      :person_id => @person.id, 
      :day => "#{Time.now.strftime('%A').downcase}",
      :week => "#{current_week}"
      )
    @notification.save
    
    @agent.notifications_today.should eq(1)
  end
  
  it "should make a full name out of first and last" do
    @agent = Factory.build(:agent, :first_name => "concat", :last_name => "test")
    @agent.full_name.should eq("concat test")
  end
  
end