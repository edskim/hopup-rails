module ApplicationHelper
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to sign_in_path, notice: "Please sign in."
      end
    end

    def redirect_if_not_current_user(user_id)
      if current_user.id != user_id.to_i
        flash[:error] = 'Request denied.'
        redirect_to current_user
      end
    end
end
