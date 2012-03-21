require 'spec_helper'

describe "NewPeople" do
  describe "POST users/new_person_path" do
    it "Creates a new person." do
      person = Person.create(:address => "123 Street Rd", 
        :city => "Newport Beach", 
        :state => "CA", 
        :zip => "92660", 
        :phone => "(714) 512-2526", 
        :mobile_phone => "7145122526", 
        :first_name => "Test", 
        :last_name => "Person", 
        :agent_id => 12
        )
        
      visit users_new_person_path
      fill_in "Address", :with => person.address
      # fill_in "City", :with => person.city
      # fill_in "State", :with => person.state
      fill_in "Zip", :with => person.zip
      fill_in "Phone", :with => person.phone
      # fill_in "Mobile phone", :with => person.mobile_phone
      fill_in "First name", :with => person.first_name
      fill_in "Last name", :with => person.last_name
      fill_in "Password", :with => "123"
      fill_in "Password confirmation", :with => "123"
      fill_in "Email", :with => "test-1234987@dustinboling.com"
      click_button "Sign up!"
      page.should have_content("Signed up!")
    end
  end
end
