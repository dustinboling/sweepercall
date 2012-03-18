class Agent < ActiveRecord::Base
  
  require 'digest/md5'
  
  before_validation :strip_outgoing_phone  
  before_create :set_uuid
  
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
  validates_presence_of :outgoing_phone
  validates_length_of :outgoing_phone, :is => 10, :message => "Phone number must contain exactly 10 numbers: XXX-XXX-XXXX"
  validates_format_of :outgoing_email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :allow_blank => true
  
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
  
  def strip_outgoing_phone
    if self.outgoing_phone.match(/^1/)
      self.outgoing_phone = self.outgoing_phone.sub('1', '').gsub(/([-() ])/, '')
    else
      self.outgoing_phone = self.outgoing_phone.gsub(/([-() ])/, '')
    end
  end
  
  # Count the total number of addresses an agent is doing reminders for.
  def count_addresses
    self.people.collect { |a| a.address }.count
  end
  
  def count_neighborhoods
    @zip_codes = []
    self.people.collect do |n|
      unless @zip_codes.include?(n.zip)
        @zip_codes << n.zip
      end
    end
    @zip_codes.count
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
end