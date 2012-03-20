xml.Response do
  xml.Dial :callerId => "+17146377157", :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}", :method => "GET" do |d|
    phone_number = "#{params[:phone_number]}"
    d.Number phone_number
    d.Say "Hello, please record your outgoing message. Press # when finished."
    d.Record(
      :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}",
      :method => "GET",
      :maxLength => "30",
      :finishOnKey => "#"
      )
    d.Say "I did not recieve a recording"
  end
end