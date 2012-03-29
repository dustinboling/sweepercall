class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    unless User.find_by_email(params[:email]).nil?
      @user = User.find_by_email(params[:email])
    end
    
    if user
      if @user.account_confirmed_at.nil?
        flash[:notice] = "You must confirm your account before logging in. Check your email!"
        render :new
      elsif user.role? :agent
        redirect_to agent_path(:id => Agent.find_by_user_id(user.agent.user_id)), :notice => "Logged in!"
      elsif user.role? :subscriber
        redirect_to person_path(:id => Person.find_by_user_id(user.person.user_id)), :notice => "Logged in!"
      elsif user.role? :admin
        redirect_to users_path, :notice => "Hello #{user.email}, logged in as admin!"
      end
    else
      flash[:notice] = "Email or password incorrect."
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
  
  def forgot_password
  end
end