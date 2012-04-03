class SweepMailer < ActionMailer::Base
  default from: "mailer@sweepercall.com"
  
  def sweep_notification(person, agent)
    @agent = agent
    @person = person
    
    # set the agent's email as "from", if applicable
    if @person.agent_id == 12 
      @from = "mailer@sweepercall.com"
    elsif @person.agent_id == nil
      @from = "mailer@sweepercall.com"
    else
      @from = Agent.find(@person.agent_id).outgoing_email
    end

    # send the mail off  
    mail(:to => Person.find(@person.id).email,
         :from => @from,
         :subject => "SweeperCall Notification")
  end
  
end
