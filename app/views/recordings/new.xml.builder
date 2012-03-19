xml.Response do
  xml.Say "Dialing Phone Number"
  xml.Dial :callerId => "14155992671" do |d|
    d.Number "#{params[:phone_number]}"
  end
end