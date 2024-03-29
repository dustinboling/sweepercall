class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :agent

  validates_presence_of :plan_id
  validates_presence_of :email

  attr_accessible :stripe_card_token, :plan_id, :email, :agent_id

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end

  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while createing customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def set_trial_started_on
    agent = @agent
    subscription = @subscription
      
  end
end
