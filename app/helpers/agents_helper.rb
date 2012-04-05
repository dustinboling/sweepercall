module AgentsHelper 
  def phone_not_verified?
    @account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    @auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @caller_id_list = @account.outgoing_caller_ids.list.collect { |id| id.phone_number }
    
    if @caller_id_list.include?("+#{@agent.outgoing_phone}") || @caller_id_list.include?("+1#{@agent.outgoing_phone}")
      false
    else
      true
    end
  end
  
  def subscription_inactive?
    if @agent.active == false
      true
    elsif @agent.active == true
      false
    else
      true
    end
  end

  def get_subscription(token)
    customer = Stripe::Customer.retrieve("#{token}")
    customer.subscription
  end

  def to_dollars(cents)
    centf = cents.to_f
    dollars = (centf / 100)
    number_to_currency(dollars)
  end
end
