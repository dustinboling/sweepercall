require 'spec_helper'

describe SmsNotification do
  it "should belong to an agent" do
    s = SmsNotification.reflect_on_association(:agent)
    s.macro.should eq(:belongs_to)
  end  
end
