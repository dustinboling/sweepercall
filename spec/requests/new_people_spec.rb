require 'spec_helper'

describe "NewPeople" do
  describe "GET /new_person_path" do
    it "Creates a new person." do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      person = Factory(:person)
      visit people_path
      click_link "New Person"
      fill_in "Address", :with => person.address
      fill_in "City", :with => person.city
      fill_in "State", :with => person.state
      fill_in "Zip", :with => person.zip
      fill_in "Phone", :with => person.phone
      fill_in "Mobile phone", :with => person.mobile_phone
      fill_in "Name", :with => person.name
      fill_in "Agent", :with => person.agent_id
      click_button "Create Person"
      page.should have_content("Person was successfully created.")
    end
  end
end
