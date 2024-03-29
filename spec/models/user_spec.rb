require 'spec_helper'

describe User do
  
  it "should have a valid factory" do
    Factory.build(:user).should be_valid
  end
  
  it "has one agent" do
    u = User.reflect_on_association(:agent)
    u.macro.should eq(:has_one)
  end
  
  it "has one person" do 
    u = User.reflect_on_association(:person)
    u.macro.should eq(:has_one)
  end
  
  it "should require an email" do
    Factory.build(:user, :email => "").should_not be_valid
  end
  
  it "should require a password" do 
    Factory.build(:user, :password => "").should_not be_valid
  end
  
  it "should require a password confirmation" do
    Factory.build(:user, :password => "secret", :password_confirmation => "").should_not be_valid
  end
  
  it "should validate the format of the email" do
    Factory.build(:user, :email => "alan@dustinbolingcom").should_not be_valid
    Factory.build(:user, :email => "alandustinbolingcom").should_not be_valid
    Factory.build(:user, :email => "alandustinboling.com").should_not be_valid
    Factory.build(:user, :email => "alan@dustinboling.com2").should_not be_valid
  end
  
end