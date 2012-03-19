xml.Response do
  xml.Say "Dialing Phone Number"
  xml.Dial :callerId => "+14155992671" do |d|
    phone_number = "#{params[:phone_number]}"
    d.Number phone_number
  end
  xml.Say "Could not reach phone number"
end