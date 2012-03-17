class Agent < ActiveRecord::Base
  
  require 'digest/md5'
  
  before_validation :strip_phone  
  before_create :set_uuid
  before_create :set_outgoing_phone
  before_create :strip_phone
  before_update :strip_phone
  
  belongs_to :user
  has_many :people
  
  has_many :recordings
  accepts_nested_attributes_for :recordings, :allow_destroy => true
  
  has_many :email_notifications
  accepts_nested_attributes_for :email_notifications, :allow_destroy => true
  
  has_many :sms_notifications
  accepts_nested_attributes_for :sms_notifications, :allow_destroy => true
  
  validate :maximum_one_active_sms_notification, :maximum_one_active_email_notification, :maximum_one_active_voice_notification
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone
  validates_length_of :phone, :is => 10, :message => "Phone number must contain exactly 10 numbers: XXX-XXX-XXXX"
  validates_format_of :outgoing_email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  
  def maximum_one_active_sms_notification
    active_sms = self.sms_notifications.collect { |s| s.active }
    
    if active_sms.count(true) > 1
      errors.add(:SMS_notificaitons, ": You can only have one active SMS notification at a time")
    end
  end
  
  def maximum_one_active_email_notification
    active_email = self.email_notifications.collect { |e| e.active }
    
    if active_email.count(true) > 1
      errors.add(:email_notifications, ": You can only have one active Email notification at a time")
    end
  end
  
  def maximum_one_active_voice_notification
    active_recordings = self.recordings.collect { |r| r.active }
    
    if active_recordings.count(true) > 1
      errors.add(:voice_recordings, ": You can only have one active Voice recording at a time")
    end
  end
  
  def set_uuid
    self.uuid = Digest::MD5.hexdigest("#{self.user_id}" + "#{self.first_name}" + "#{self.last_name}")
  end
  
  def set_outgoing_phone
    self.outgoing_phone = self.phone
  end
  
  def set_outgoing_email
    @user_id = self.user_id
    self.outgoing_email = User.find(@user_id).email
  end
  
  def strip_phone
    self.phone = "#{self.phone.gsub(/([-() ])/, '')}"
  end
  
  # Count the total number of addresses an agent is doing reminders for.
  def count_addresses
    self.people.collect { |a| a.address }.count
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
end