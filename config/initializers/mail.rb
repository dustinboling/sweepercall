ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app2920382@heroku.com'],
  :password       => ENV['QCserqcMp3w9KszK*AtBx7uQhw'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp