require 'spec_helper'

describe PeopleHelper do
  describe "type_display" do
    it "should display email when type is 1" do
      type_display(1).should eq("Email")
    end
    
    it "should display sms when type is 2" do
      type_display(2).should eq("SMS")
    end
    
    it "shoud display voice when type is 3" do
      type_display(3).should eq("Voice")
    end
  end
  
end