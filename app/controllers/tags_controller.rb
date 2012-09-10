class TagsController < ApplicationController
  include TagsHelper

  before_filter :signed_in_user
  before_filter :check_if_current_user, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    if params[:topic_id]
      @tags = Topic.find(params[:topic_id]).tags
    else
      @tags = current_user.created_topics.inject([]) { |all_tags, topic| all_tags + topic.tags }
    end
    respond_with(@tags)
  end

  def show
    @tag = Tag.find(params[:id])
    respond_with(@tag)
  end

  def new
    @topic_id = params[:topic_id]
  end

  def create
    @tag.location, @tag.lat, @tag.lng = request_coordinates(@tag.location)
    if @tag.save
      flash[:success] = 'Tag created'
    end
    respond_with(@tag)
  end

  def edit
  end

  def update
    if !params[:tag][:location].blank?
      params[:tag][:location], params[:tag][:lat], params[:tag][:lng] = 
            request_coordinates(params[:tag][:location])
    end
    if @tag && @tag.update_attributes(params[:tag])
      flash[:success] = 'Tag successfully updated'
    end
    respond_with(@tag)
  end

  def destroy
    @tag.destroy
    flash[:success] = 'Tag is deleted.'
    respond_with(@tag)
  end
  
  private

    def check_if_current_user
      if params[:topic_id]
        @tag = Tag.new( topic_id: params[:topic_id] )
      elsif params[:id]
        @tag = Tag.find(params[:id])
      elsif params[:tag]
        @tag = Tag.new(params[:tag])
      end
      redirect_if_not_current_user( Topic.find(@tag.topic_id).creator_id)
    end
end
