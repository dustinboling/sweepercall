class EmailConfirmationsController < ApplicationController
  
  skip_before_filter :require_login
  
  def confirm
    @user = User.find_by_account_confirmation(params[:id])
    @user.account_confirmed_at = Time.now
  end
  
end