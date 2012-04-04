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

end
