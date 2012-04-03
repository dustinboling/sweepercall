require 'spec_helper'

describe AgentsHelper do
  describe "phone_not_verified" do 
    it "queries twilio to see if the agent's phone number is verified" do
      @agent = Factory.build(:agent, :outgoing_phone => "000000000")
      @agent.save
      phone_not_verified?.should == true
    end
  end

  describe "subscription_inactive?" do
    it "checks if the agent's subscription is inactive" do
      @agent = Factory(:agent)
      subscription_inactive?.should == true
      
      @agent.active = true
      @agent.save
      subscription_inactive?.should == false
    end
  end
  
end
