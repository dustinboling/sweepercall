xml.Response do
  xml.Dial :callerId => "+19496129779", :action => "http://sweepercall.heroku.com/recordings/create.xml?uuid=#{params[:uuid]}", :method => "GET", :record => true do |d|
    phone_number = "#{params[:phone_number]}"
    message = "19496129779"
    d.Number phone_number
    d.Number message
  end
end