class RemindersController < ApplicationController
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
