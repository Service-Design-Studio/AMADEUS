class SessionsController < ApplicationController
    

    def admin
        if user_signed_in?
            render "admin"
        else
            flash[:danger] = "You must be logged in to access this section"
            redirect_to "/sign_in"
        end
    end


end
# class SessionsController < ApplicationController

#     def new

#         # if current_user
#         #     redirect_to "/admin"
#         # end

#         # if session[:user_id] == "admin"
#         #     redirect_to "/admin"
#         # end
#     end

#     def create

#         # if params[:email] == "admin" && params[:password] == "admin"
#         #     session[:user_id] = "admin"
#         #     flash[:success] = "Logged in successfully."
#         #     redirect_to "/admin"
#         # else
#         #     flash[:danger] = "Invalid email or password"
#         #     redirect_to "/sign_in"
#         # end

#         # if user.present? && user.authenticate(params[:password])
#         #     session[:user_id] = user.id
#         #     flash[:success] = "Logged in successfully."
#         # else
#         #     flash[:error] = "Invalid email or password"
#         #     redirect_to "/sign_in"
#         # end
#     end

#     def admin
#         # if session[:user_id] == "admin"
#         #     render "admin"
#         # else
#         #     flash[:danger] = "You must be logged in to access this section"
#         #     redirect_to "/sign_in"
#         # end
#     end

#     def destroy
#         session[:user_id] = nil
#         flash[:success] = "Logged out successfully."
#         redirect_to root_path
#     end

# end