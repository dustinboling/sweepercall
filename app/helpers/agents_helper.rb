module AgentsHelper
  def phone_not_verified?
    @account_sid = 'ACe079c3003a2c4a1d949806c681648262'
    @auth_token = '85bcc52edb352a11a19b8de47b4437fb'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @caller_id_list = @account.outgoing_caller_ids.list.collect { |id| id.phone_number }
    
    if @caller_id_list.include?("+#{@agent.outgoing_phone}") || @caller_id_list.include?("+1#{@agent.outgoing_phone}")
      false
    else
      true
    end
  end
  
end