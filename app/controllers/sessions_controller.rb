class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ApplicationHelper
  def admin
    if user_signed_in?
      render "admin"
    else
      flash[:danger] = FlashString::TO_LOGIN
      redirect_to "/sign_in"
    end
  end
end
