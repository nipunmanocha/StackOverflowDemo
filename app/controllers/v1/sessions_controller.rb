class V1::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      render json: user, status: :ok
    else
      render json: { error: "Incorrect Username/Password combination" }, status: 400
    end
  end

  def destroy
    log_out if logged_in?
    render json: { message: "Successfully Logged Out" }, status: 201
  end
end
