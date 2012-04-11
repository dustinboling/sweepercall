if params[:Digits] == "1"
  tw_redirect = "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}&RecordingUrl=#{params[:RecordingUrl]}"
elsif params[:Digits] == "0"
  tw_redirect = "http://sweepercall.heroku.com/recordings/record.xml?uuid=#{params[:uuid]}"
end

xml.Response do
  xml.Redirect tw_redirect, :method => "GET"
end
