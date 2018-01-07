class UsersController < ApplicationController
  before_action :is_valid_user, only: [:update, :destroy]

  def index
    @users = User.active
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Stack Overflow!"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    return render json: @user.errors, status: 500 unless @user.update_attributes(update_params)
    render json: @user, status: :ok
  end

  def destroy
    @user.deleted_at = Time.now
    return render json: @user.errors, status: 500 unless @user.save(validate: false)
    render json: @user, status: 201
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:name, :email)
  end

  def is_valid_user
    @user = User.active.find_by(id: params[:id])
    render json: { error: 'Invalid User' }, status: 404 unless @user
  end
end