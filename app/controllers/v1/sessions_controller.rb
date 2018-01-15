require_relative '../../services/user_registration'

class V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user_registration = UserRegistration.new(user)
      render json: user_registration.log_in(session, cookies), status: :ok
    else
      render json: { error: "Incorrect Username/Password combination" }, status: 400
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    if user
      user_registration = UserRegistration.new(user)
      user_registration.log_out(session, cookies)
    end
    render json: { message: "Successfully Logged Out" }, status: 201
  end
end
