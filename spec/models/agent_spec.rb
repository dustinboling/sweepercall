require 'spec_helper'

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

describe Agent do
  
  it "has a valid factory" do
    Factory.build(:agent).should be_valid
  end
  
  it "requires a first name" do
    
  end  
  
end