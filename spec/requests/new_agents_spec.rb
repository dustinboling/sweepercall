require 'spec_helper'

describe "NewAgents" do
  it "creates a new agent" do
    agent = Factory(:agent)
    visit agents_path
    click_link "New Agent"
    fill_in "First name", :with => agent.first_name
    fill_in "Last name", :with => agent.last_name
    fill_in "Email", :with => agent.email
    click_button "Create Agent"
    page.should have_content("Agent was successfully created.")
  end
end