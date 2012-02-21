class RecordingsController < ApplicationController
  def record
    @agent = Agent.find_by_uuid(params[:uuid])
    
    @account_sid = 'ACe079c3003a2c4a1d949806c681648262'
    @auth_token = '85bcc52edb352a11a19b8de47b4437fb'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
    @call = @client.account.calls.create(
      :from => '14155992671',
      :to => @agent.phone,
      :url => 'http://sweepercall.heroku.com/recordings/new.xml'
    )
    
    respond_to do |format|
      format.html # record.xml
    end
  end
  
  def new
    redirect_to 'http://sweepercall.heroku.com/recordings/new.xml'
  end
  
  def create
    
  end

end
