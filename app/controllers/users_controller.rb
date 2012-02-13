class UsersController < ApplicationController
  

  
  def index
    @users = User.order('id ASC')
  end
  
  def new
    @user = User.new
  end
  
  def new_person
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up! Check your email for account details."
    else
      render :new
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
