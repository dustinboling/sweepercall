# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create some users for agent # 12
n = 1
100.times do 
  User.create(:roles_mask => 2, :email => "example#{n}@dustinbling.com")
  Person.create(:first_name => Faker::first_name, :last_name => Faker::last_name, :agent_id => 12, :phone => "7145122526")
end
