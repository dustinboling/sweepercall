require 'spec_helper'

describe Person do 
  
  it "should have a valid factory" do
    Factory.build(:person).should be_valid
  end
  
  it "belongs to user" do
    p = Person.reflect_on_association(:user)
    p.macro.should eq(:belongs_to)
  end
  
  it "belongs to agent" do
    p = Person.reflect_on_association(:agent)
    p.macro.should eq(:belongs_to)
  end
  
  it "belongs to agent" do
    
  end
  
  it "should require a first_name" do
    Factory.build(:person, :first_name => "").should_not be_valid
  end 
  
  it "should require an address" do
    Factory.build(:person, :address => "").should_not be_valid
  end
  
  it "should require a city" do
    Factory.build(:person, :city => "").should_not be_valid
  end
  
  it "should require a state" do
    Factory.build(:person, :state => "").should_not be_valid
  end
  
  it "should require a zip code" do
    Factory.build(:person, :zip => "").should_not be_valid
  end
  
  it "should require a phone number" do
    Factory.build(:person, :phone => "").should_not be_valid
  end
  
  it "should not accept invalid phone numbers" do
    Factory.build(:person, :phone => "71451225266").should_not be_valid
    Factory.build(:person, :phone => "145122526").should_not be_valid
    Factory.build(:person, :phone => "(7144) 512-2526").should_not be_valid
    Factory.build(:person, :phone => "(714) 512-25266").should_not be_valid
  end
  
  it "should accept valid phone numbers (including numbers prefixed with a one)" do
    Factory.build(:person, :phone => "7145122526").should be_valid
    Factory.build(:person, :phone => "(714) 512-2526").should be_valid
    Factory.build(:person, :phone => "17145122526").should be_valid
    Factory.build(:person, :phone => "1-714-512-2526").should be_valid
    Factory.build(:person, :phone => "1 (714) 512-2526").should be_valid
    Factory.build(:person, :phone => "1 714 512-2526").should be_valid
    Factory.build(:person, :phone => "1 (714) 512 2526").should be_valid
    Factory.build(:person, :phone => "1 714 512 2526").should be_valid
  end
  
  # strip phone ommitted as it is already in agent spec
  
end