class RecordingsController < ApplicationController
  
  def new
  end
  
  def dial
  end
  
  def record_prompt
  end
  
  def notification
  end
  
  def record_landing
    @agent = Agent.find_by_uuid(params[:uuid])
  end
  
  def record
    @agent = Agent.find_by_uuid(params[:uuid])

    account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    
    @call = @client.account.calls.create(
      :from => '19496129779',
      :to => @agent.outgoing_phone,
      :url => "http://sweepercall.heroku.com/recordings/new.xml?uuid=#{params[:uuid]}",
      :method => "GET"
    )
    
    respond_to do |format|
      format.html # record.xml
    end
  end
  
  def confirm
  end

  def confirm_branch
    if params[:Digits] == 1
      render :create, :uuid => params[:uuid], :RecordingUrl => params[:RecordingUrl]
    elsif params[:Digits] == 0
      render :record, :uuid => params[:uuid]
    end
  end

  def create
    @agent = Agent.find_by_uuid(params[:uuid])
    
    # store file on amazon
    AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIM3ERMFQV5XL5KMQ', :secret_access_key => '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')
    begin
      sleep 4
      AWS::S3::S3Object.store("#{params[:RecordingUrl].split('/').pop}.mp3", open("#{params[:RecordingUrl]}.mp3"), 'SweeperCallAgentRecordings', :access => :public_read)
    rescue /404 NOT FOUND/
      sleep 1
      AWS::S3::S3Object.store("#{params[:RecordingUrl].split('/').pop}.mp3", open("#{params[:RecordingUrl]}.mp3"), 'SweeperCallAgentRecordings', :access => :public_read)
    end
    @file = AWS::S3::S3Object.find("#{params[:RecordingUrl].split('/').pop}.mp3", 'SweeperCallAgentRecordings')
     
    # save url to postgres
    @recording = Recording.new(:agent_id => @agent.id, :recording_url => @file.url)
    @recording.save    
  end
  
  def destroy
    # find recording in database
    @recording = Recording.find(params[:id])
    
    # delete file from amazon
    long_url = @recording.recording_url.split('/').pop
    url = long_url.split('?').first

    AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIM3ERMFQV5XL5KMQ', :secret_access_key => '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')
    AWS::S3::S3Object.delete("#{url}", 'SweeperCallAgentRecordings')
    
    # delete record from database
    @recording.destroy
    

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end
  
end
