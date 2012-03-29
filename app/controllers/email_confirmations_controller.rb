class EmailConfirmationsController < ApplicationController
  
  skip_before_filter :require_login
  
  def confirm
    if User.find_by_account_confirmation(params[:token]).nil?
      redirect_to :action => "confirmation_failed"
    else
      @user = User.find_by_account_confirmation(params[:token])
      
      # set user to confirmed
      @user.account_confirmed_at = Time.now
      @user.save
    end
  end
  
  def confirmation_failed
  end
  
end