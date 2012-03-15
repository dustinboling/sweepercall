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
      # log in as admin
      # visit root_url
      # click_link "Manage Users"
      # page.should have_content("Listing users")
      # click_link "Manage People"
      # page.should have_content("Listing people")
      # click_link "Manage Agents"
      # page.should have_content("Listing agents")
    end
  end
  
end