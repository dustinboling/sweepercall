xml.Response do
  xml.Say "Hello, please record your outgoing message. Press # when finished."
  xml.Record(
    :action => "http://sweepercall.heroku.com/recordings/create?uuid=#{params[:uuid]}",
    :method => "POST",
    :maxLength => "30",
    :finishOnKey => "#")
end