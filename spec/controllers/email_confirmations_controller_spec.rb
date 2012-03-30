require 'spec_helper'

describe EmailConfirmationsController do
  describe "GET /confim" do  
    it "sets the user's account_confirmed_at field" do
      @user = Factory(:user, :account_confirmation => "token")
      
      get :confirm, :token => @user.account_confirmation
      @user.account_confirmed_at.should_not be_nil
    end
  end
end