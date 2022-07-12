class SessionsController < ApplicationController
  def admin
    if user_signed_in?
      render "admin"
    else
      flash[:danger] = FlashString::TO_LOGIN
      redirect_to "/sign_in"
    end
  end
end
