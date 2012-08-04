class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
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
