require 'spec_helper'

describe AgentsHelper do
  describe "phone_not_verified" do 
    it "queries twilio to see if the agent's phone number is verified" do
      @agent = Factory.build(:agent, :outgoing_phone => "000000000")
      @agent.save
      phone_not_verified?.should == true
    end
  end
  
end