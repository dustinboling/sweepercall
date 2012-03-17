require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AgentsHelper do
  describe "phone_not_verified" do 
    it "queries twilio to see if the agent's phone number is verified" do
      @agent = Factory.build(:agent, :outgoing_phone => "7145122526")
      @agent.save
      phone_not_verified?.should == false
    end
  end
  
end