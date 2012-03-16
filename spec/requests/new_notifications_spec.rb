require 'spec_helper'

describe "NewNotifications" do
  before :each do
    @person = Person.create(:first_name => 'Test', 
      :last_name => 'Subscriber', 
      :address => '1800 Quail St', 
      :city => 'Newport Beach', 
      :state => 'CA', 
      :zip => '92660',
      :phone => "(714) 512-2526"
      )
  end
  
  describe "CREATE /people/:id/notification, :notification_type => 1 (email)" do
    it "adds some email notifications to a person" do
      
      i = 1
      4.times do
        Notification.create(:person_id => @person.id, :notification_type => 1, :day => 'monday', :week => "#{i}" )
        i = i + 1
      end
      
      @person.notifications.where(:notification_type => 1).count.should eq(4)
    end
  end
  
  describe "CREATE /people/:id/notification, :notification_type => 2 (text)" do
    it "adds some text notifications to a person" do
      
      i = 1
      4.times do
        Notification.create(:person_id => @person.id, :notification_type => 2, :day => 'monday', :week => "#{i}" )
        i = i + 1
      end
      
      @person.notifications.where(:notification_type => 2).count.should eq(4)
    end
  end
  
  describe "CREATE /people/:id/notification, :notification_type => 3 (voice)" do
    it "adds some voice notifications to a person" do
      
      i = 1
      4.times do
        Notification.create(:person_id => @person.id, :notification_type => 3, :day => 'monday', :week => "#{i}" )
        i = i + 1
      end
      
      @person.notifications.where(:notification_type => 3).count.should eq(4)
    end
  end
  
end