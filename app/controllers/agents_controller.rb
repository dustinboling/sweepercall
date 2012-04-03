class AgentsController < ApplicationController
  
  load_and_authorize_resource
  
  layout :resolve_layout
  
  def resolve_layout
    case action_name
    when "show", "edit"
      "agent"
    when "index", "new"
      "application"
    else
      "application"
    end
  end
  
  def verify
    require 'twilio-ruby'
    @account_sid = 'ACbc18a2ac1712bd298d743d0f395defc4'
    @auth_token = 'cccf865524c94ab9dff4de6cc98d70c3'
    
    @agent = Agent.find_by_uuid(params[:uuid])
    @agent_phone = params[:phn]
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    @account = @client.account
    @new_id = @account.outgoing_caller_ids.create({:phone_number => params[:phn]})
    
    flash[:notice] = "#{@new_id.validation_code}"
  end
  
  # GET /agents
  # GET /agents.json
  def index
    @agents = Agent.all
    authorize! :read, @agents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agents }
    end
  end

  # GET /agents/1
  # GET /agents/1.json
  def show
    @agent = Agent.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/new
  # GET /agents/new.json
  def new
    @agent = Agent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent }
    end
  end

  # GET /agents/1/edit
  def edit
    @agent = Agent.find(params[:id])
  end

  # POST /agents
  # POST /agents.json
  def create
    @agent = Agent.new(params[:agent])

    respond_to do |format|
      if @agent.save
        format.html { redirect_to @agent, notice: 'Your account has been created!' }
        format.json { render json: @agent, status: :created, location: @agent }
      else
        format.html { render action: "new" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agents/1
  # PUT /agents/1.json
  def update
    @agent = Agent.find(params[:id])

    respond_to do |format|
      if @agent.update_attributes(params[:agent])
        format.html { redirect_to @agent, notice: 'Your profile has been updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agents/1
  # DELETE /agents/1.json
  def destroy
    # find the agent and associated user
    @agent = Agent.find(params[:id])
    @user = User.find(@agent.user_id)
    
    # destroy them
    @agent.destroy
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to agents_url }
      format.json { head :ok }
    end
  end
end
