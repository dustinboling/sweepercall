class UsersController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => [:new, :new_person, :create]
  
  def index
    @users = User.order('id ASC')
  end
  
  def new
    @user = User.new
  end
  
  def new_person
    @user = User.new
    
    if params[:uuid].nil?
      params[:uuid] = 'DBA001'
    else
      @agent_id = Agent.find_by_uuid(params[:uuid]).id
    end
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      redirect_to root_url, :notice => "Signed up! Check your email to confirm your account."
    else
      # this only works on the first refresh.
      # need to render full path somehow on render :new_person
      # or use referring method instead of URI
      if URI(request.referer).path == '/users/new_person'
        render :new_person
      else
        render :new
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, :notice => 'User has been successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

end
