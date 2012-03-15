require 'spec_helper'

describe "NewPeople" do
  describe "GET /new_person_path" do
    it "Creates a new person." do
      person = Person.create(:address => "123 Street Rd", :city => "Newport Beach", :state => "CA", :zip => "92660", :phone => "(714) 512-2526", :mobile_phone => "7145122526", :first_name => "Test", :last_name => "Person", :agent => "32")
      visit new_person_path
      fill_in "Address", :with => person.address
      fill_in "City", :with => person.city
      fill_in "State", :with => person.state
      fill_in "Zip", :with => person.zip
      fill_in "Phone", :with => person.phone
      fill_in "Mobile phone", :with => person.mobile_phone
      fill_in "Name", :with => person.name
      fill_in "Agent", :with => person.agent_id
      fill_in "Password", :with => user.password
      fill_in "Password", :with => "123"
      click_button "Sign up!"
      page.should have_content("Person was successfully created.")
    end
  end
end
