# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create some users for agent # 12
# change agent_id to whatever your development agent is.
# NOTE: this does not create user accounts along with the people
100.times do 
  Person.create(:first_name => Faker::Name::first_name, 
    :last_name => Faker::Name::last_name, 
    :address => Faker::Address::street_address(include_secondary = false),
    :city => Faker::Address::city,
    :state => Faker::Address::state,
    :zip => Faker::Address::zip_code, 
    :agent_id => 12, 
    :phone => "7145122526")
end
