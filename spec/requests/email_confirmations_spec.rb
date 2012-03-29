require 'spec_helper'

describe "EmailConfirmations" do
  it "should say thanks for confirming your account if the token is valid" do
    user = Factory(:user, :account_confirmation => "token", :account_confirmed_at => nil)
    visit("/email_confirmations/confirm?token=#{user.account_confirmation}") 
    
    page.should have_content("Thanks for confirming your account!")
  end
  
  it "should redirect to the fail page if a token is invalid" do
    user = Factory(:user, :email => "alan-test-124984@dustinboling.com", :account_confirmation => "token", :account_confirmed_at => nil)
    visit("/email_confirmations/confirm?token=invalid_token")
    
    page.should have_content("Something went wrong!")
  end
  
end