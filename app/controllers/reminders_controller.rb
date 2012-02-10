class RemindersController < ApplicationController
  
  load_and_authorize_resource
  
  def email
    @person = Person.find_by_id(1)
    @agent = Agent.find_by_id(1)
    
    SweepMailer.reminder_email(@person).deliver
    
  end

  def sms
  end

  def voice
  end

end
