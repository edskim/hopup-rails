class SubscriptionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_current_user, only: [ :create, :destroy ]

  def index
    @subscriptions = current_user.subscriptions
    respond_with(@subscriptions)
  end

  def create
    respond_to do |format|
      if @subscription.save 
        flash[:success] = 'Topic subscribed' 
        format.html { redirect_to topics_path }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        flash[:error] = 'Topic not subscribed'
        format.html { redirect_to topics_path }
        format.json { render json: "Subscription not created.", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription.destroy
    flash[:success] = 'Unsubscribed from topic'
    respond_with(@subscription)
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
