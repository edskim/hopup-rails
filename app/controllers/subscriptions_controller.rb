class SubscriptionsController < ApplicationController

  def index
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      flash[:success] = 'Topic subscribed'
      redirect_to topics_path
    else
      flash[:error] = 'Topic not subscribed'
      redirect_to topics_path
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    flash[:success] = 'Unsubscribed from topic'
    redirect_to subscriptions_path(user_id: @subscription.user_id)
  end
  
end
