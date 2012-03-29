require "spec_helper"

describe UserMailer do
  describe "reset_password_email" do
    let(:user) { Factory(:user, :reset_password_token => "token") }
    let(:mail) { UserMailer.reset_password_email(user) }

    it "sends password reset url" do
      mail.subject.should eq("Reset your password! - SweeperCall")
      mail.to.should include(user.email)
      mail.from.should include("mailer@sweepercall.com")
    end

    it "renders the url to password token in the body" do
      mail.body.encoded.should match("http://sweepercall.heroku.com/password_resets/#{user.reset_password_token}/edit")
    end  
  end
  
  describe "registration_confirmation" do
    let(:user) { Factory(:user, :email => "test@dustinboling.com") }
    let(:mail) { UserMailer.registration_confirmation(user) }
    
    it "sends a confirmation email" do
      mail.subject.should eq("Confirm your account! - SweeperCall")
      mail.to.should include(user.email)
      mail.from.should include("accounts@sweepercall.com")
    end
    
    it "has the confirmation token & url in the body" do
      mail.body.encoded.should match("http://sweepercall.heroku.com/email_confirmations/#{user.account_confirmation}/confirm")
    end
  end
  
end