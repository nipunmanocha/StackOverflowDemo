module SessionInfo
  extend ActiveSupport::Concern

  included do
    def log_in(user)
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !current_user.nil?
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def require_login
      render json: { redirect_url: v1_signup_path }, status: :unauthorized unless session[:user_id]
    end
  end
end