xml.response do 
  xml.say "You recorded the following message"
  xml.play params[:RecordingUrl]
end