class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      if user.role? :agent
        redirect_to agent_path(:id => Agent.find_by_user_id(user.agent.user_id)), :notice => "Logged in!"
      elsif user.role? :subscriber
        redirect_to person_path(:id => Person.find_by_user_id(user.person.user_id)), :notice => "Logged in!"
      elsif user.role? :admin
        redirect_to users_path, :notice => "Hello admin."
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
end