class TagsController < ApplicationController
  include TagsHelper

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
    @topic_id = params[:topic_id]
  end

  def create
    @tag = Tag.new(params[:tag])
    @tag.location, @tag.lat, @tag.lng = request_coordinates(@tag.location)
    if @tag.save
      flash[:success] = 'Tag created'
      redirect_to @tag.topic
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if !params[:tag][:location].blank?
      params[:tag][:location], params[:tag][:lat], params[:tag][:lng] = 
            request_coordinates(params[:tag][:location])
    end
    if @tag && @tag.update_attributes(params[:tag])
      flash[:success] = 'Tag successfully updated'
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def destroy
  end
  
end
