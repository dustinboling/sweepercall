class Agent < ActiveRecord::Base
  belongs_to :user
  has_many :people
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :first_name,
            :presence => true
  validates :last_name,
            :presence => true
end
