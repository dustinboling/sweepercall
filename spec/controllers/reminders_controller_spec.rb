require 'spec_helper'

describe RemindersController do

  describe "GET 'email'" do
    it "returns http success" do
      get 'email'
      response.should be_success
    end
  end

  describe "GET 'sms'" do
    it "returns http success" do
      get 'sms'
      response.should be_success
    end
  end

  describe "GET 'voice'" do
    it "returns http success" do
      get 'voice'
      response.should be_success
    end
  end

end
