Factory.define :person do |f|
  f.address Faker::Address.street_address(include_secondary = false)
  f.city Faker::Address.city
  f.state Faker::Address.state
  f.zip Faker::Address.zip
  f.phone "714-512-2526"
  f.mobile_phone "7145122526"
  f.first_name Faker::Name.first_name
  f.last_name Faker::Name.last_name
  f.agent_id "1"
end

Factory.define :agent do |f|
  f.first_name "Test"
  f.last_name "Agent"
  f.sequence(:outgoing_email) { |n| "test-456-987-#{n}@example.com" }
  f.outgoing_phone "7145122526"
end

Factory.define :notification do |f|
  f.notification_type "1"
  f.day "monday"
  f.week "1st"
  f.person
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "test-account-#{n}@dustinboling.com" }
  f.password "123"
  f.password_confirmation "123"
end

Factory.define :recording do |f|
  f.recording_url "http://www.thisistest.com/recording/?45678903vhjdbfiucwbifwe874ub"
  f.active false
end