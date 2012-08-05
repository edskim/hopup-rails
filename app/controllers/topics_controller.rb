class TopicsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_if_current_user, only: [ :create, :edit, :update, :destroy ]

  def index
    @topics = Topic.all
    respond_with(@topics)
  end

  def show
    @topic = Topic.find(params[:id])
    respond_with(@topic)
  end

  def new
    @topic = Topic.new
  end

  def create
    if @topic.save
      flash[:success] = 'Topic created'
    end
    respond_with(@topic)
  end

  def edit
  end

  def update
    if @topic && @topic.update_attributes(params[:topic])
      flash[:success] = 'Topic updated'
    end
    respond_with(@topic)
  end

  def destroy
    @topic.destroy
    flash[:success] = 'Topic deleted.'
    respond_with(@topic)
  end
  
  private

    def check_if_current_user
      if params[:id]
        @topic = Topic.find(params[:id])
      elsif params[:topic]
        @topic = Topic.new(params[:topic])
      end
      redirect_if_not_current_user(@topic.creator.id)
    end
end
