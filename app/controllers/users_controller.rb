class UsersController < ApplicationController
  # before_action :is_valid_user, only: [:update, :destroy]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(id: params[:id]) #remove this line when you uncomment before_action
    return render json: @user.errors, status: :unprocessable_entity unless @user.update_attributes(update_params)
    render json: @user, status: :ok
  end

  def destroy
    @user = User.find_by(id: params[:id]) #remove this line when you uncomment before_action
    @user.deleted_at = Time.now
    log_out
    return render json: @user.errors, status: :internal_server_error unless @user.save(validate: false)
    render json: @user, status: :ok
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def update_params
      params.require(:user).permit(:name, :email)
    end

    def is_valid_user
      @user = User.find_by(id: params[:id])
      return render json: { error: 'Invalid User' }, status: :not_found unless @user
      render json: { error: "Invalid Action" }, status: :unauthorized if @user.id != session[:user_id]
    end
end
