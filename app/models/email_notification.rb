class EmailNotification < ActiveRecord::Base
  belongs_to :agent
  
  scope :active, where(:active => true)
  
end
