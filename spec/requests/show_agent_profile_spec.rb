require 'spec_helper'

describe "GET agent profile :as => agent" do
  before :each do
    @user = Factory(:user, :roles_mask => 1)
    @agent = Factory(:agent, :user_id => @user.id)
    @person = Factory(:person, :agent_id => @agent.id)
    @notification = Factory(:notification, :person_id => @person.id)
    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => '123'
    click_button "Log in"
  end
  
  # agent#show
  it "should say the agent has logged in" do
    page.should have_content("Logged in!")
  end
  
  it "has a notification of the agent's signup url" do
    page.should have_content("http://localhost:3000/users/new_person?uuid=#{@agent.uuid}")
  end
  
  it "should count the number of addresses an agent is notifying" do
    page.should have_content("1Total Addresses")
  end
  
  it "should show the edit button" do
    page.should have_link("Edit your profile")
  end
  
  # agent#edit
  it "should link back to agent#show from edit" do
    click_link "Edit"
    click_link "Back"
    page.should have_content("Hello #{@agent.first_name} #{@agent.last_name}!")
  end
  
  it "should say the phone number is not verified when it is not" do
    @agent.outgoing_phone = "(000) 000-0000"
    @agent.save
    click_link "Edit"
    page.should have_content("No")
  end
  
  it "should display a list of agent's voice notifications" do
    @agent.recordings.create(:agent_id => @agent.id)
    click_link "Account"
    page.should have_content("#{Time.now.strftime('%d %b %Y')}")
  end
end