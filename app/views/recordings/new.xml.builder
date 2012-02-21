xml.Response do
  xml.Say "Hello, please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create.html?uuid=#{params[:uuid]}",
    :method => "POST",
    :maxLength => "30",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording."
end