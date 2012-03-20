xml.Response do
  xml.Say "Please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}",
    :method => "GET",
    :maxLength => "30",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording"
end