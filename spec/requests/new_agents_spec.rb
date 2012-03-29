require 'spec_helper'

describe "NewAgents" do
  it "creates a new agent" do
    visit root_path
    click_link "Agent sign up!"
    fill_in "Phone", :with => "(714) 512-2526"
    fill_in "First name", :with => "Gaius"
    fill_in "Last name", :with => "Baltar"
    fill_in "Email", :with => "testing123@dustinboling.com"
    fill_in "Password", :with => "123"
    fill_in "Password confirmation", :with => "123"
    click_button "Sign up!"
    page.should have_content("Signed up! Check your email to confirm your account")
  end
  
  it "should email a user when they set up an account" do
    
  end
  
end