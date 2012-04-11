xml.Response do
  xml.Gather(
    :action => "http://sweepercall.heroku.com/recordings/confirm_branch.xml?uuid=#{params[:uuid]}",
    :method => "GET") do
    xml.Say "This is the message your recorded"
    xml.Play "#{params[:RecordingUrl]}"
    xml.Say "If you would like to keep this message press 1. If you would like to re RECORD press 2"
  end
end
