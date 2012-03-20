require 'spec_helper'

describe "GET admin areas, show them" do
  before :each do 
    @admin_user = Factory(:user, :roles_mask => 4)
    
    visit login_path
    fill_in "Email", :with => @admin_user.email
    fill_in "Password", :with => '123'
    click_button "Log in"
  end
  
  it "says hello to the admin" do
    page.should have_content("logged in as admin!")
  end
  
  # users#index
  it "should have the warning about destroy being disabled" do
    page.should have_content("Notice: Destroy has been disabled on the users model.")
  end
  
  it "should display a list of users" do
    @u1 = Factory(:user, :roles_mask => 1)
    @u2 = Factory(:user, :roles_mask => 2)
    
    click_link "Manage Users"
    page.should have_content("#{@u1.id}")
    page.should have_content("#{@u2.id}")
    page.should have_content("1")
    page.should have_content("2")
  end
  
  # people#index
  it "should show a list of people" do
    @p1 = Factory(:person, :agent_id => "1001")
    @p2 = Factory(:person, :agent_id => "2002")
    click_link "Manage Subscribers"
    page.should have_content("#{@p1.first_name}")
    page.should have_content("#{@p1.last_name}")
    page.should have_content("#{@p1.address}")
    page.should have_content("#{@p1.city}")
    page.should have_content("#{@p1.zip}")
    page.should have_content("#{@p1.state}")
    page.should have_content("1001")
    page.should have_content("#{@p2.first_name}")
    page.should have_content("#{@p2.last_name}")
    page.should have_content("#{@p2.address}")
    page.should have_content("#{@p2.city}")
    page.should have_content("#{@p2.zip}")
    page.should have_content("#{@p2.state}")
    page.should have_content("2002")
    page.should have_link("Edit")
    page.should have_link("Destroy")
  end
  
  # agents#index
  
end