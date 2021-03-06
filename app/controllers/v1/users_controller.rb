class V1::UsersController < ApplicationController
  before_action :require_login, only: [:update, :destroy]
  before_action :authenticate_user, only: [:update, :destroy]

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: user, status: :ok
  end

  def create
    render json: User.create!(user_params), status: :created
  end

  def update
    user.update!(user_update_params)
    render json: user, status: :ok
  end

  def destroy
    user.destroy!
    head :ok
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :email)
    end

    def user
      User.find_by(id: params[:id])
    end

    def authenticate_user
      head :unauthorized unless user && user == current_user
    end
end
