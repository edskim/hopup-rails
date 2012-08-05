class TopicsController < ApplicationController
  before_filter :signed_in_user
  before_filter :check_if_current_user, only: [ :create, :edit, :update, :destroy ]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    if @topic.save
      flash[:success] = 'Topic created'
      redirect_to @topic.creator
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic && @topic.update_attributes(params[:topic])
      flash[:success] = 'Topic updated'
      redirect_to @topic
    else
      flash[:error] = 'Invalid changes'
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    flash[:success] = 'Topic deleted.'
    redirect_to @topic.creator
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
