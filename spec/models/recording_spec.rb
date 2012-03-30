require 'spec_helper'

describe Recording do
  it "should belong to an agent" do
    r = Recording.reflect_on_association(:agent)
    r.macro.should eq(:belongs_to)
  end
end
