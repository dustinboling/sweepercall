require 'spec_helper'

describe Subscription do
  it "has a valid factory" do
    Factory.build(:subscription).should be_valid
  end

  it "belongs to agent" do
    s = Subscription.reflect_on_association(:agent)
    s.macro.should eq(:belongs_to)
  end

  it "belongs to plan" do
    s = Subscription.reflect_on_association(:plan)
    s.macro.should eq(:belongs_to)
  end

  it "should require a plan_id" do
    s = Factory.build(:subscription, :plan_id => "").should_not be_valid
  end

  it "should require an email" do
    s = Factory.build(:subscription, :email => "").should_not be_valid
  end 

end
