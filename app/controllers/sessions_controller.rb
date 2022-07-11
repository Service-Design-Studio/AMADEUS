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
