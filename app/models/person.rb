class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent
  
  validates_presence_of :first_name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone
  
  has_many :notifications
  accepts_nested_attributes_for :notifications, :reject_if => lambda { |n| n[:person_id].blank? }, :allow_destroy => true
  
end