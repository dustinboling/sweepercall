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
  
  it "should say admin is logged in" do
    page.should have_content("Logged in as #{@admin_user.email}")
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
  it "should show a list of agents" do
    @a1 = Factory(:agent)
    @a2 = Factory(:agent, :last_name => 'Agent2', :website_url => "something.com")
    
    click_link "Manage Agents"
    page.should have_content(@a1.id)
    page.should have_content(@a1.user_id)
    page.should have_content(@a1.first_name)
    page.should have_content(@a1.last_name)
    page.should have_content(@a1.outgoing_phone)
    page.should have_content(@a1.user.email)
    page.should have_content(@a1.outgoing_email)
    page.should have_content(@a1.website_url)

    page.should have_content(@a2.id)
    page.should have_content(@a2.user_id)
    page.should have_content(@a2.first_name)
    page.should have_content(@a2.last_name)
    page.should have_content(@a2.outgoing_phone)
    page.should have_content(@a2.user.email)
    page.should have_content(@a2.outgoing_email)
    page.should have_content(@a2.website_url)

    page.should have_link("Edit")
    page.should have_link("Destroy")
  end
end
