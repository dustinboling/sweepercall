require 'spec_helper'

describe "LayoutLinks" do
  
  describe "Get /home" do
    it "links to the home url" do
      visit root_url
      click_link "Home"
      page.should have_content("Welcome to sweepercall.")
    end
  end
  
  describe "GET links :as => admin" do
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
  
end