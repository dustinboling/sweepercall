class RecordingsController < ApplicationController
  
  def new
  end
  
  def record
    @agent = Agent.find_by_uuid(params[:uuid])    
    @account_sid = 'ACe079c3003a2c4a1d949806c681648262'
    @auth_token = '85bcc52edb352a11a19b8de47b4437fb'
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
    @call = @client.account.calls.create(
      :from => '14155992671',
      :to => @agent.outgoing_phone,
      :url => "http://sweepercall.heroku.com/recordings/new.xml?uuid=#{params[:uuid]}"
    )
    
    respond_to do |format|
      format.html # record.xml
    end
  end
  
  def create
    @agent = Agent.find_by_uuid(params[:uuid])
    
    # store file on amazon
    AWS::S3::S3Object.store("#{params[:RecordingUrl]}", open("#{params[:RecordingUrl]}.mp3"), 'SweeperCallAgentRecordings')
    @file = AWS::S3::S3Object.find("#{params[:RecordingUrl]}", 'SweeperCallAgentRecordings')
    @url = @file.url
     
    # save url to postgres
    @recording = Recording.new(:agent_id => @agent.id, :recording_url => @file.url)
    @recording.save
    
  end
  
  def destroy
    @recording = Recording.find(params[:id])
    @recording.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
  
end