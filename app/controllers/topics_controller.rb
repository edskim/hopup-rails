class TopicsController < ApplicationController

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
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:success] = 'Topic created'
      redirect_to @topic.user
    else
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic && @topic.update_attributes(params[:topic])
      flash[:success] = 'Topic updated'
      redirect_to @topic
    else
      flash[:error] = 'Invalid changes'
      render 'edit'
    end
  end

  def destroy
  end
  
end
