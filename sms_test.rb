require 'twilio-ruby'

@account_sid = 'ACe079c3003a2c4a1d949806c681648262'
@auth_token = '85bcc52edb352a11a19b8de47b4437fb'

# sets up twilio client
@client = Twilio::REST::Client.new @account_sid, @auth_token

# example sms
@client.account.sms.messages.create(
  :from => '14155992671', 
  :to => '17145122526', 
  :body => 'testing sms functionality for website')
  
  
############################
#   verify agent phone     #
#                          #
############################

# This sends the outgoing call to the agent to verify their phone, allowing
# us to pass in the phone number
def verify
  @agent_phone = params[:phn]
  @account = @client.account
  @outgoing_caller_id = @account.outgoing_caller_ids.create({:phone_number => agent_phone})
  puts @outgoing_caller_id
end