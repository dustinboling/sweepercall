xml.Response do
  xml.Dial :callerId => "+14155992671" do |d|
    d.Number "#{params[:phone_number]}"
  end
  xml.Say "Hello, please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}",
    :method => "GET",
    :maxLength => "30",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording."
end