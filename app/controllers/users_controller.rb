class UsersController < ApplicationController
  before_filter :signed_in_user, only: [ :index, :edit, :update, :destroy]
  before_filter :correct_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Account created.'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user && @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = 'Changes saved successfully'
      redirect_to @user
    else
      flash[:error] = 'Invalid changes'
      render 'edit'
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:error] = 'You do not have permission to edit that information.'
        redirect_to current_user
      end
    end
end
