class Agent < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with NotificationSingularity
  
  require 'digest/md5'
  
  before_validation :strip_phone
  before_create :set_uuid
  before_create :strip_phone
  before_update :strip_phone
  
  belongs_to :user
  has_many :people
  
  
  validates_presence_of :phone
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  has_many :recordings
  accepts_nested_attributes_for :recordings, :allow_destroy => true
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone
  validates_length_of :phone, :is => 10, :message => "Phone number must contain exactly 10 numbers: XXX-XXX-XXXX"
  
  has_many :email_notifications
  accepts_nested_attributes_for :email_notifications, :allow_destroy => true
  
  has_many :sms_notifications
  accepts_nested_attributes_for :sms_notifications, :allow_destroy => true
  
  def set_uuid
    self.uuid = Digest::MD5.hexdigest("#{self.user_id}" + "#{self.first_name}" + "#{self.last_name}")
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