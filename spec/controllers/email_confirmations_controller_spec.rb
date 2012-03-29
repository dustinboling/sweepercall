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

# it "should set account_confirmed_at for a valid token" do
#   user = User.create(:account_confirmation => "token", 
#     :email => "test456728765@dustinboling.com", 
#     :password => "123",
#     :password_confirmation => "123"
#     )
#   visit("/email_confirmations/confirm?token=#{user.account_confirmation}")
#   
#   @user = User.find_by_account_confirmation(params[:token])
#   @user.account_confirmed.should_not be_nil
# end