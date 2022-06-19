class SessionsController < ApplicationController

    def new
        if session[:user_id] == "admin"
            redirect_to "/admin"
        end
    end

    def create
        # user = User.find_by(email: params[:email])

        if params[:email] == "admin" && params[:password] == "admin"
            session[:user_id] = "admin"
            flash[:success] = "Logged in successfully."
            redirect_to uploads_path
        else
            flash[:danger] = "Invalid email or password"
            redirect_to "/sign_in"
        end

        # if user.present? && user.authenticate(params[:password])
        #     session[:user_id] = user.id
        #     flash[:success] = "Logged in successfully."
        # else
        #     flash[:error] = "Invalid email or password"
        #     redirect_to "/sign_in"
        # end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "Logged out successfully."
        redirect_to root_path
    end

    def admin
    end

end