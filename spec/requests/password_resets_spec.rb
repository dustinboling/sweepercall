require 'spec_helper'

describe "PasswordResets" do
  
  it "should email a user when they request to have their password reset" do
    @user = Factory(:user)
    reset_email
    visit forgot_password_path
    fill_in "Email", :with => @user.email
    click_button "Reset my password!"
    page.should have_content("Instructions have been sent to your email")
    last_email.to.should include(@user.email)
  end
  
  it "should not email a user if they are not in the database" do
    visit forgot_password_path
    fill_in "Email", :with => "email_not_in_database@gmail.com"
  end
  
end