class Agent < ActiveRecord::Base
  
  before_create :set_uuid
  
  belongs_to :user
  has_many :people
  
  
  validates_presence_of :phone
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  has_many :recordings
  accepts_nested_attributes_for :recordings, :allow_destroy => true
  
  has_many :email_notifications
  accepts_nested_attributes_for :email_notifications, :allow_destroy => true
  
  has_many :sms_notifications
  accepts_nested_attributes_for :sms_notifications, :allow_destroy => true
  
  # Not really a UUID! (but it will always be unique within this particular
  # ecosystem)
  def set_uuid
    self.uuid = SecureRandom.hex(16) + "#{self.user_id}"
  end
  
  # Count the total number of addresses an agent is doing reminders for.
  def count_addresses
    self.people.collect { |a| a.address }.count
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end

end