class NotificationSingularity < ActiveModel::Validator
  def validate(record)
    if already_has_active?
      record.errors[:base] = "You can only have one active notification at a time for each type"
    end
  end
  
  private
  
  def already_has_active?
    active_email = @agent.email_notifications.collect { |a| a.active }
    active_sms = @agent.sms_notifications.collect { |b| a.active }
    active_recordings = @agent.recordings.collect { |b| a.active }
    
    if active_email.include?('true') || active_sms.include?('true') || active_recordings.include?('true')
      true
    else
      false
    end
  end
end