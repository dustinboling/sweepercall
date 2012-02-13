class Agent < ActiveRecord::Base
  
  before_create :set_uuid
  
  belongs_to :user
  has_many :people
  
  # not really a UUID! (but it will always be unique within this particular
  # ecosystem)
  def set_uuid
    self.uuid = SecureRandom.hex(16) + "#{self.user_id}"
  end
  
end
