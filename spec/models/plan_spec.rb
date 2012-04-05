require 'spec_helper'

describe Plan do
  it "should belong to subscription" do
    p = Plan.reflect_on_association(:subscription)
    p.macro.should eq(:belongs_to)
  end
end
