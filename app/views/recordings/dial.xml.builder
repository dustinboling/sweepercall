xml.Response do
  xml.Say "Dialing #{params[:phone_number]}"
  xml.Dial :callerId => "+17146377157", :action => "http://sweepercall.heroku.com/recordings/new.xml?uuid=#{params[:uuid]}", :method => "GET" do |d|
    phone_number = "#{params[:phone_number]}"
    d.Number phone_number
  end
  xml.Say "Could not connect to #{params[:phone_number]}"
end