class RecordingsController < ApplicationController
  
  def new
  end
  
  def dial
  end
  
  def record_prompt
  end
  
  def record_landing
    @agent = Agent.find_by_uuid(params[:uuid])    
  end
  
  def record
    @agent = Agent.find_by_uuid(params[:uuid])    
    @account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    @auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
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
    AWS::S3::S3Object.store("#{params[:RecordingUrl].split('/').pop}.mp3", open("#{params[:RecordingUrl]}.mp3"), 'SweeperCallAgentRecordings', :access => :public_read)
    @file = AWS::S3::S3Object.find("#{params[:RecordingUrl].split('/').pop}.mp3", 'SweeperCallAgentRecordings')
     
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