require 'spec_helper'

describe "GET subscriber profile :as => agent" do
  before :each do
    @user = Factory(:user, :roles_mask => 2)
    @agent = Factory(:agent)
    @person = Factory(:person, :user_id => @user.id, :agent_id => @agent.id)
    
    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => '123'
    click_button "Log in"
  end
  
  # person#show
  it "should say the subscriber has logged in" do
    page.should have_content("Logged in!")
  end
  
  it "should say hello!" do
    page.should have_content("Hello #{@person.first_name}")
  end
  
  it "should say there are no notifcations, if none are set up" do
    page.should have_content("You do not have any notifications set up.")
  end
  
  it "should list the person's contact info" do
    # This is a form for right now
    # page.should have_content("#{@person.city}")
    # page.should have_content("#{@person.zip}")
    # page.should have_content("#{@person.phone}")
    # page.should have_content("#{@person.mobile_phone}")
  end
  
  it "should display a list of the person's notifications" do
    # Not currently allowing an agent to set up these notifications.
    
    # @n1 = Factory(:notification, :person_id => @person.id, :notification_type => 1)
    # @n1.save
    # @n2 = Factory(:notification, :person_id => @person.id, :notification_type => 2)
    # @n2.save
    # @n3 = Factory(:notification, :person_id => @person.id, :notification_type => 3)
    # @n3.save
    # 
    # click_link "Account"
    # page.should have_content(@n1.week)
    # page.should have_content("#{@n2.week}")
    # page.should have_content("#{@n3.week}")
    # page.should have_content("Monday")
    # page.should have_content("Email")
    # page.should have_content("SMS")
    # page.should have_content("Voice")
  end
  
  it "should not say there are no notifications, if there are" do
    @n1 = Factory(:notification, :person_id => @person.id, :notification_type => 1)
    @n1.save
    
    click_link "Account"
    page.should_not have_content("You do not have any notifications set up.")
  end
  
end