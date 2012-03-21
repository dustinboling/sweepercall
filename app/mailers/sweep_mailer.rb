class SweepMailer < ActionMailer::Base
  default from: "mailer@sweepercall.heroku.com"
  
  def sweep_notification(person, agent)
    @agent = agent
    @person = person
    
    # set the agent's email as "from", if applicable
    if @person.agent_id.blank?
      @from = "mailer@sweepercall.heroku.com"
    else
      @agent_id = Agent.find_by_id(@person.agent_id).user_id
      @from = User.find_by_id(@agent_id).email
    end
    
    # send the mail off  
    mail(:to => User.find_by_id(@person.user_id).email,
         :from => @from,
         :subject => "Street sweeping tomorrow, move your car!")
  end
  
end