class PasswordResetsController < ApplicationController
  
  skip_before_filter :require_login
  
  def create
    if @user = User.find_by_email(params[:email])
      @user.deliver_reset_password_instructions! if @user
      redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
    else
      redirect_to(root_path, :notice => 'Email address not found!')
    end
  end

  # password reset form
  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end
  
  # fires when user has sent the reset password form.
  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user
    # makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, :notice => 'Password was successfully updated.')
    else
      render :action => 'edit'
    end
  end
end