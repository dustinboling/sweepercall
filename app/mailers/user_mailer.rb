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
         :subject => "Reset your password")
  end
  
  def registration_confirmation(user)
    @user = user
    mail(:to => user.email, 
         :subject => "New Account Registered at SweeperCall")
  end
  
end