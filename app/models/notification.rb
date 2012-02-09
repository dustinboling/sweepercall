class Notification < ActiveRecord::Base
  belongs_to :person
  
  validates_presence_of :notification_type, :day, :week
  
end
