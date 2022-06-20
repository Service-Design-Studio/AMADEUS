class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        "/admin"
        # session[:show_navbar] = true
    end
end
