describe "PasswordResets" do
  
  it "emails a user when they request to have their password reset" do
    @user = Factory(:user)
    visit login_path
    fill_in "Email", :with => @user.email
    click_button "Reset my password!"
    page.should have_content("Instructions have been sent to your email")
  end
  
end