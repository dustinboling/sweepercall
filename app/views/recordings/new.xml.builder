xml.response do
  xml.say "Hello, please record your outgoing message. Press # when finished."
  xml.record(
    :action => "http://sweepercall.com/recordings/create.html.erb",
    :method => "POST",
    :maxLength => "20",
    :finishOnKey => "#")
end