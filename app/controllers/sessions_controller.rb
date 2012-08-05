class SessionsController < ApplicationController
  respond_to :html, :json

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        sign_in user
        format.html { redirect_to user }
        format.json { render json: user, status: :signed_in, location: user }
      else
        flash.now[:error] = 'Invalid email or password.'
        format.html { render 'new' }
        format.json { render json: "Signin unsuccessful.", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
