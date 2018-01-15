class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  include ErrorHandlers

  def require_login
    render json: { redirect_url: v1_signup_path }, status: :unauthorized unless session[:user_id]
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        @current_user = user
      end
    end
  end
end
