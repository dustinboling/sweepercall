xml.Response do
  xml.Dial "7145122526"
  xml.Say "Hello, please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}",
    :method => "GET",
    :maxLength => "30",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording."
end