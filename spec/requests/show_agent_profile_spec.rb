require 'spec_helper'
include ActionView::Helpers::NumberHelper

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
    page.should have_content("http://sweepercall.heroku.com/users/new_person?uuid=#{@agent.uuid}")
  end
  
  it "should have a not subscribed notification if the agent is not subscribed" do
    @agent.active = false
    @agent.save
    click_link "Account"

    page.should have_content("You do not have an active subscription. Outgoing message functionality is currently disabled")
  end

  it "should link to the subscription page if an agent is not subscribed" do
    @agent.active = false
    @agent.save
    click_link "Account"

    page.should have_link("subscribe now")
  end

  it "should not have a not subscribed notification if the agent is subscribed" do
    @agent.active = true
    @agent.save
    
    click_link "Account"
    page.should_not have_content("You do not have an active subscription. Outgoing message functionality is currently disabled")
  end

  it "should say an agent doesn't have an subscriptions if they do not" do
    page.should have_content("You do not have any subscriptions")
  end

  it "should list a subscription if an agent is subscribed" do
    subscription = Subscription.create(:plan_id => 1, :email => @user.email, :agent_id => @agent.id)
    # SKIP: outside api kills this one.
    # click_link "Account"
    # page.should have_content("#{@agent.subscriptions.first.plan_id}")
  end

  it "should count the number of addresses an agent is notifying" do
    page.should have_content("1Total Addresses")
  end
  
  it "should not show the edit button" do
    page.should_not have_link("Edit your profile")
  end
  
  it "should not show the 'create a recording' button if the agent's phone number is not verified" do
    @agent.outgoing_phone = "(000) 000-1000"
    @agent.save
    
    click_link "Account"
    page.should have_content("You are using the default message right now")
  end
  
  it "should allow an agent to connect to the record LANDING page" do
    click_link "Create a Recording"
    page.should have_content("Click the button below and we will call you at #{number_to_phone(@agent.outgoing_phone)} so you can make your recording.")
    page.should have_link("Call me now!")
  end
  
  it "should say the phone number is not verified when it is not" do
    @agent.outgoing_phone = "(000) 000-0000"
    @agent.save
    
    click_link "Account"
    page.should have_content("No (verify now!)")
  end
  
  it "should display a list of agent's voice notifications" do
    @agent.recordings.create(:agent_id => @agent.id)
    
    click_link "Account"
    page.should have_content("#{Time.now.strftime('%d %b %Y')}")
  end
 
  # The following 2 tests are ok, but they connect to Twilio and make a recording,
  # which we do not want.
  it "should allow an agent to connect to the ACTUAL recording page" do
    # click_link "Create a Recording"
    # click_link "Call me now!"
    # page.should have_content("You are receiving a call right now at #{number_to_phone(@agent.outgoing_phone)}")
  end
  
  it "should provide a link for the agent to get back to their home page from recordings#record" do
    # click_link "Create a Recording"
    # click_link "Call me now!"
    # page.should have_content("When you have finished your recording, click here to go back to your profile.")
    # 
    # click_link "here"
    # page.should have_content("Hello #{@agent.first_name} #{@agent.last_name}!")
  end
  
end
