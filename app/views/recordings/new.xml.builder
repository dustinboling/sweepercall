xml.response do
  xml.say "Hello, please record your outgoing message. Press # when finished."
  xml.record(
    :action => "http://sweepercall.heroku.com/recordings/create",
    :method => "POST",
    :maxLength => "30",
    :finishOnKey => "#")
end