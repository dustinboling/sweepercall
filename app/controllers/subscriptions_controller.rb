class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
    if current_user && current_user.roles_mask == 1
      @agent = Agent.find(current_user.agent)
    else
      redirect_to root_url, :notice => "You must be logged in to access this page."
    end
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    @agent = Agent.find(params[:subscription][:agent_id])

    if @subscription.save_with_payment
      @agent.active = true
      @agent.save

      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @agent = Agent.find(@subscription.agent_id)
    @count = @agent.subscriptions.count

    if @count == 1
      # set agent's account to inactive
      @agent.active = false
      @agent.save

      # destroy subscription
      @subscription.destroy
    else
      @subscription.destroy
    end
      

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
end
