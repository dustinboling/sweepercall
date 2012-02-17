namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    # uncomment to delete these guys
    # [Person, Notifications].each(&:delete_all)
  
    User.populate 20 do |user|
      User.email = 
    
      Person.populate 20 do |person|
        person.first_name
        person.last_name
      end
    end
  
    Notification.populate 1000 do |notification|
    
    end
  end  
end