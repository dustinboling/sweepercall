class SweepMailer < ActionMailer::Base
  default from: "admin@dustinboling.com"
  
  def sweep_notification(person, agent)
    @agent = agent
    @person = person
    mail(:to => person.email, :subject => "Street sweeping tomorrow, move your car!")
  end
  
end