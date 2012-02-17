namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
    
    # uncomment to delete these guys
    # [Person, Notifications].each(&:delete_all)
  
    User.populate 100 do |user|
      User.email = Faker::Internet.email
      User.password = 123
    
      Person.populate 100 do |person|
        person.first_name
        person.last_name
      end
    end
  
    Notification.populate 1000 do |notification|
    
    end
  end  
end