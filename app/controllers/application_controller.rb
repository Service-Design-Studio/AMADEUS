class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        "/admin"
    end

    def require_login
        if current_user.nil?
            flash[:danger] = FlashString::TO_LOGIN
            redirect_to "/sign_in"
        end
    end

    def user_not_authorized
        flash[:danger] = FlashString::USER_NOT_AUTHORIZED
    end
end
