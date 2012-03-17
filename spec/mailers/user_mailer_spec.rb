require "spec_helper"

describe UserMailer do
  describe "reset_password_email" do
    let(:user) { Factory(:user, :reset_password_token => "token") }
    let(:mail) { UserMailer.reset_password_email(user) }

    it "sends password reset url" do
      mail.subject.should eq("Reset your password")
      mail.to.should include(user.email)
      mail.from.should include("mailer@sweepercall.com")
    end

    it "renders the url to password token in the body" do
      mail.body.encoded.should match("http://0.0.0.0:3000/password_resets/#{user.reset_password_token}/edit")
    end
  
  end

end