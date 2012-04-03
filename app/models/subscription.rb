class Subscription < ActiveRecord::Base
  belongs_to :plan

  validates_presence_of :plan_id
  validates_presence_of :email

  attr_accessible :stripe_card_token
end
