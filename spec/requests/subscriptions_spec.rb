require 'spec_helper'

describe "Subscriptions" do
  before :each do
    @user = Factory(:user, :roles_mask => 1)
    @agent = Factory(:agent, :user_id => @user.id)

    visit login_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => '123'
    click_button "Log in"
  end

  it "should say the agent has logged in" do
    page.should have_content("Logged in!")
  end

  it "should allow an agent to sign up for a subscription" do
    @agent.active = false
    @agent.save

    click_link "Account"
    click_link "subscribe now"

    fill_in "Credit Card Number", :with => '4242424242424242'
    fill_in "Security Code on Card (CVV)", :with => '123'
    select "January", :from =>  "card_month"
    select '2016', :from => "card_year"
    click_button "New subscription"
    page.should have_content("Your Subscription")
  end

  it "should allow an agent to cancel a subscription" do
    @agent.active = false
    @agent.save

    click_link "Account"
    click_link "subscribe now"

    fill_in "Credit Card Number", :with => '4242424242424242'
    fill_in "Security Code on Card (CVV)", :with => '123'
    select "January", :from =>  "card_month"
    select '2016', :from => "card_year"
    click_button "New subscription"
    
    click_link "Account"
    click_link "Cancel Subscription"
    page.driver.browser.switch_to.alert.accept
    page.should have_content("You do not have any subscriptions yet.")
  end

  it "should not allow an agent to create a second trial subscription" do
    @agent.active = false
    @agent.save

    click_link "Account"
    click_link "subscribe now"

    fill_in "Credit Card Number", :with => '4242424242424242'
    fill_in "Security Code on Card (CVV)", :with => '123'
    select "January", :from =>  "card_month"
    select '2016', :from => "card_year"
    click_button "New subscription"
    
    click_link "Account"
    click_link "Cancel Subscription"
    page.driver.browser.switch_to.alert.accept

    click_link "Account"
    click_link "subscribe now"

    fill_in "Credit Card Number", :with => '4242424242424242'
    fill_in "Security Code on Card (CVV)", :with => '123'
    select "January", :from =>  "card_month"
    select 2016, :from => "card_year"
    click_button "New subscription"
    page.should have_content("You have already signed up for a trial subscription")
  end
end
