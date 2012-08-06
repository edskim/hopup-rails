module ApplicationHelper
    def signed_in_user
      unless signed_in?
        respond_to do |format|
          store_location
          format.html { redirect_to signin_path, notice: "Please sign in." }
          format.json { render json: { error: "You must be signed in to do that"}, status: :unprocessable_entity }
        end
      end
    end

    def redirect_if_not_current_user(user_id)
      if current_user.id != user_id.to_i
        respond_to do |format|
          flash[:error] = 'Request denied.'
          format.html { redirect_to current_user }
          format.json { render json: "You do not have permission to do that", status: :unprocessable_entity }
        end
      end
    end
end
