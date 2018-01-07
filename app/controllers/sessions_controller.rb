class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      render json: user, status: :ok
    else
      render json: { error: "Incorrect Username/Password combination" }, status: 400
    end

    # if user && user.authenticate(params[:session][:password])
    #   log_in user
    #   redirect_to user
    # else
    #   flash.now[:danger] = 'Incorrect Username/Password combination'
    #   render 'new'
    # end
  end

  def destroy
    log_out
    render json: { message: "Successfully Logged Out" }, status: 201
    # redirect_to root_url
  end
end
