class SubscriptionsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
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
  end
  
end
