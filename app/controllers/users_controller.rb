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
      log_in @user
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end

    # respond_to do |format|
    #   if @user.save
    #     flash[:success] = "Welcome to Stack Overflow!"
    #     log_in @user
    #     format.html { redirect_to @user }
    #     format.json { render json: @user, status: :created, location: @user }
    #   else
    #     format.html { render 'new' }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @user.name ||= update_params[:name] 
    @user.email ||= update_params[:email]
    return render json: @user.errors, status: 500 unless @user.save(validate: false)
    render json: @user, status: :ok
  end

  def destroy
    @user.deleted_at = Time.now
    log_out
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
      return render json: { error: 'Invalid User' }, status: 404 unless @user
      render json: { error: "Invalid Action" } if @user.id != session[:user_id]
    end
end
