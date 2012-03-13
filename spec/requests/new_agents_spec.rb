require 'spec_helper'

describe "NewAgents" do
  it "creates a new agent" do
    agent = Agent.create(:phone => "(714) 512-2526", :first_name => "Test", :last_name => "Person")
    user = User.create(:email => "alan20@dustinboling.com")
    visit root_path
    click_link "Agent sign up!"
    fill_in "Phone", :with => agent.phone
    fill_in "First name", :with => agent.first_name
    fill_in "Last name", :with => agent.last_name
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "123"
    fill_in "Password confirmation", :with => "123"
    click_button "Sign up!"
    page.should have_content("Agent was successfully created.")
  end
  
end