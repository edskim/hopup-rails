class SubscriptionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_current_user, only: [ :create, :destroy ]

  def index
  end

  def create
    if @subscription.save
      flash[:success] = 'Topic subscribed'
      redirect_to topics_path
    else
      flash[:error] = 'Topic not subscribed'
      redirect_to topics_path
    end
  end

  def destroy
    @subscription.destroy
    flash[:success] = 'Unsubscribed from topic'
    redirect_to subscriptions_path(user_id: @subscription.user_id)
  end

  private

    def check_current_user
      if params[:id]
        @subscription = Subscription.find(params[:id])
      elsif params[:subscription]
        @subscription = Subscription.new(params[:subscription])
      end
      redirect_if_not_current_user(@subscription.user_id)
    end
end
