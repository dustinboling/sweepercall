class Notification < ActiveRecord::Base
  belongs_to :person
  
  validates_presence_of :notification_type, :day, :week
  
  NOTIFICATION_TYPES = [["Email", 1], ["Text", 2], ["Voice", 3]]
  NOTIFICATION_DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  NOTIFICATION_WEEKS = ["1st", "2nd", "3rd", "4th"]
  
  
end