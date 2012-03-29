class UserMailer < ActionMailer::Base
  default from: "mailer@sweepercall.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url = "http://sweepercall.heroku.com/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
         :subject => "Reset your password! - SweeperCall")
  end
  
  def registration_confirmation(user)
    @user = user
    @url = "http://sweepercall.heroku.com/email_confirmations/#{user.account_confirmation}/confirm"
    mail(:to => user.email, 
         :from => "accounts@sweepercall.com",
         :subject => "Confirm your account! - SweeperCall")
  end
  
end