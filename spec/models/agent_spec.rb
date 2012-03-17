require 'spec_helper'

describe Agent do
  
  it "has a valid factory" do
    Factory.build(:agent).should be_valid
  end
  
  it "should require a first name" do
    Factory.build(:agent, :first_name => "").should_not be_valid
  end  
  
  it "should require a last name" do
    Factory.build(:agent, :last_name => "").should_not be_valid
  end
  
  it "should require a phone number" do
    Factory.build(:agent, :phone => "").should_not be_valid
  end 
  
  it "should only accept valid phone numbers" do
    # valid examples
    Factory.build(:agent, :phone => "7145122526").should be_valid
    Factory.build(:agent, :phone => "17145122526").should be_valid
    Factory.build(:agent, :phone => "1 (714) 5122526").should be_valid
    Factory.build(:agent, :phone => "1 (714) 512-2526").should be_valid
    Factory.build(:agent, :phone => "1-714-512-2526").should be_valid
    
    # invalid examples
    Factory.build(:agent, :phone => "145122526").should_not be_valid
    Factory.build(:agent, :phone => "71451225266").should_not be_valid
    Factory.build(:agent, :phone => "171451225266").should_not be_valid
    Factory.build(:agent, :phone => "1145122526").should_not be_valid
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
  
end