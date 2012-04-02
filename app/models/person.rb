class Person < ActiveRecord::Base
  
  before_validation :strip_phone
  before_create :strip_phone
  before_update :strip_phone
  
  belongs_to :user
  belongs_to :agent
  
  validates_presence_of :first_name
  validates_presence_of :address
  validates_presence_of :zip
  validates_presence_of :phone
  validates_length_of :phone, :is => 10, :message => "Phone number must contain exactly 10 numbers: XXX-XXX-XXXX OR (XXX) XXX-XXXX "
  
  has_many :notifications
  accepts_nested_attributes_for :notifications, :reject_if => lambda { |n| n[:person_id].blank? }, :allow_destroy => true
  
  def strip_phone
    if self.phone.match(/^1/)
      self.phone = self.phone.sub('1', '').gsub(/([-() ])/, '')
    else
      self.phone = self.phone.gsub(/([-() ])/, '')
    end
  end
  
end
