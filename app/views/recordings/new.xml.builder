xml.Response do
  xml.Say "Dialing Phone Number"
  xml.Dial :callerId => "+7145122526" do |d|
    phone_number = "#{params[:phone_number]}"
    d.Number phone_number
  end
end