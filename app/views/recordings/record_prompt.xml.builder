xml.Response do
  xml.Say "Please Record your outgoing message. Press # when finished.", :voice => "woman"
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}",
    :method => "GET",
    :maxLength => "30",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording"
end