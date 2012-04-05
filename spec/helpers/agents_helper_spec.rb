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
      @agent.active = false
      @agent.save
      subscription_inactive?.should == true
      
      @agent.active = true
      @agent.save
      subscription_inactive?.should == false
    end
  end
  
  describe "get_subscription" do
    it "gets a subscription from twilio" do
      # NOTEST: outside api calls
    end
  end

  describe "to_dollars" do
    it "converts pennies to dollars" do
      # this should be $10.99
      pennies = 1099
      pennies_neg = -1099

      to_dollars(pennies).should eq("$10.99")
      to_dollars(pennies_neg).should eq("-$10.99")
    end
  end
end
