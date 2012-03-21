# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sweeper::Application.initialize!

# SendGrid Configuration
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app2920382@heroku.com'],
  :password       => ENV['chbgoj1m'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options[:host] = "sweepercall.heroku.com"


