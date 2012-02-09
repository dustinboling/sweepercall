require 'spec_helper'

describe "NewNotifications" do
  describe "CREATE /people/:id/notification" do
    it "adds a notification to a person" do
      visit people
      
      response.status.should be(200)
    end
  end
end
