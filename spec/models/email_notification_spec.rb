require 'spec_helper'

describe EmailNotification do 
  it "should belong to agent" do
    e = EmailNotification.reflect_on_association(:agent)
    e.macro.should eq(:belongs_to)
  end 

end

