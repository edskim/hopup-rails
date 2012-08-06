class UsersController < ApplicationController
  before_filter :signed_in_user, only: [ :index, :edit, :update, :destroy]
  before_filter :correct_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.all
    respond_with(@users)
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Account created.'
    end
    respond_with(@user)
  end

  def edit
  end

  def update
    if @user && @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = 'Changes saved successfully'
    end
    respond_with(@user)
  end

  private

    def correct_user
      @user = User.find(params[:id])

      redirect_if_not_current_user(@user.id)
    end
end
