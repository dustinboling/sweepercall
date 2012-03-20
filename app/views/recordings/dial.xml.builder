xml.Response do
  xml.Dial :callerId => "+19496129779" do |d|
    phone_number = "#{params[:phone_number]}"
    message = "19496129779"
    d.Number phone_number, :url => "http://sweepercall.heroku.com/recordings/record_prompt.xml?uuid=#{params[:uuid]}", :method => "GET"
  end
end