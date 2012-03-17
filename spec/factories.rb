Factory.define :person do |f|
  f.address "1800 Quail St."
  f.city "Newport Beach"
  f.state "CA"
  f.zip "92660"
  f.phone "714-512-2526"
  f.mobile_phone "7145122526"
  f.first_name "Alan"
  f.agent_id "1"
end

Factory.define :agent do |f|
  f.first_name "Test"
  f.last_name "Agent"
  f.sequence(:email) { |n| "test#{n}@example.com" }
end

Factory.define :notification do |f|
  f.notification_type "1"
  f.day "1"
  f.week "1"
end

Factory.define :user do |f|
  f.sequence(:email) { |n| "test-n8791-#{n}@dustinboling.com" }
  f.password "123"
  f.password_confirmation "123"
end