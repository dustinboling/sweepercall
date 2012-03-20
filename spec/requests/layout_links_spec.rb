require 'spec_helper'

describe "LayoutLinks" do
  
  describe "Get /home" do
    it "links to the home url" do
      visit root_url
      click_link "Home"
      page.should have_content("Welcome to sweepercall.")
    end
    
    it "should show the 'log in' link button when not loggend" do
      @user = Factory(:user)
      
      visit root_url
      page.should have_link("log in")
    end
    
    it "should not show the 'log in' button when logged in" do
      @user = Factory(:user)
      
      visit login_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => '123'
      click_button "Log in"
      page.should_not have_link("Log in")
    end
    
    
    it "should show the log out button when a user is logged in" do
      @user = Factory(:user)
      
      visit login_path
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => '123'
      click_button "Log in"
      page.should have_link("log out")
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
  
end