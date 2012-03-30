require 'spec_helper'

describe Notification do

  it "should have a valid factory" do
    n = Factory(:notification)
    n.should be_valid
  end

  it "should belong to a person" do
    n = Notification.reflect_on_association(:person)
    n.macro.should eq(:belongs_to)
  end

  it "should require a notification type" do
    Factory.build(:notification, :notification_type => "").should_not be_valid
  end

  it "should require a day " do
    Factory.build(:notification, :day => "").should_not be_valid
  end

  it "should require a week" do
    Factory.build(:notification, :week => "").should_not be_valid
  end

  it "should downcase the name when saved" do
    n = Factory(:notification, :day => "MONDAY")
    n.day.should eq("monday")
  end
end
