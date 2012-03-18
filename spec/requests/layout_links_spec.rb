require 'spec_helper'

describe "LayoutLinks" do
  
  describe "Get /home" do
    it "links to the home url" do
      visit root_url
      click_link "Home"
      page.should have_content("Welcome to sweepercall.")
    end
  end
  
  describe "GET navbar links :as => admin" do
    it "successfully links to the right pages when logged in as admin" do
      # Create an admin user
      @user = User.create(:email => "user-test1234@dustinboling.com", :password => '123', :password_confirmation => '123', :roles_mask => 4)
      # Log in as admin user
      visit login_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      # Verify admin links work
      visit root_url
      click_link "Manage Users"
      page.should have_content("Listing users")
      click_link "Manage Subscribers"
      page.should have_content("Listing people")
      click_link "Manage Agents"
      page.should have_content("Listing agents")
    end
  end
  
  describe "GET navbar links :as => agent" do
    it "successfuly links to the right pages when logged in as agent" do
      user = User.create(:email => "user-test123456@dustinboling.com", :password => '123', :roles_mask => 1)
      @agent = Agent.create(:first_name => 'TEST', 
        :last_name => 'Agent',
        :outgoing_phone => '(714) 512-2526',
        :user_id => user.id
        )
        
      # log in as agent
      visit login_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      # verify agent links work
      visit root_url
      click_link "Account"
      page.should have_content("Hello TEST")
    end
  end
  
  describe "GET navbar links :as => subscriber" do
    it "successfully links to the right pages when logged in as subscriber" do
      @user = User.create(:email => "user-test123456@dustinboling.com", :password => '123', :roles_mask => 2)
      @person = Person.create(:first_name => 'TEST', 
        :last_name => 'Subscriber', 
        :address => '1800 Quail St', 
        :city => 'Newport Beach', 
        :state => 'CA', 
        :zip => '92660',
        :phone => "(714) 512-2526",
        :user_id => @user.id
        )
        
      # log in as subscriber
      visit login_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      # verify subscriber links work
      visit root_url
      click_link "Account"
      page.should have_content("Hello TEST")
    end
  end
  
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
    
    # agent#edit
    it "should say the phone number is not verified when it is not" do
      @agent.outgoing_phone = "(000) 000-0000"
      @agent.save
      click_link "Edit"
      page.should have_content("No")
    end
    
    it "should display a list of agent's voice notifications" do
      @agent.recordings.create(:agent_id => @agent.id)
      click_link "Edit"
      page.should have_content("#{Time.now.strftime('%d %b %Y')}")
    end
    
  end
end