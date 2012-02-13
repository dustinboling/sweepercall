class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :agent
  
  has_many :notifications
  accepts_nested_attributes_for :notifications, :reject_if => lambda { |n| n[:person_id].blank? }, :allow_destroy => true
  
end
