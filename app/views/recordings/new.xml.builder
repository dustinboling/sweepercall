xml.Response do
  xml.Say "Please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/confirm.xml?uuid=#{params[:uuid]}",
    :method => "GET",
    :maxLength => "130",
    :finishOnKey => "#")
  xml.Say "I did not recieve a recording"
end
