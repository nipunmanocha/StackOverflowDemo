class V1::QuestionsController < ApplicationController
  before_action :validate_question, only: [:update, :destroy]

  def index
    @questions = Question.all
    render json: @questions , status: :ok
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, status: :ok
  end

  def create
    return render json: { redirect_url: signup_path }, status: :forbidden unless question_params[:user_id]
    @question = Question.new(question_params)
    return render json: @question.errors, status: :unprocessable_entity unless @question.save
    render json: @question, status: :created, location: @question
  end

  def update
    return render json: @question.errors, status: :unprocessable_entity unless @question.update_attributes(question_params)
    render json: @question, status: :ok
  end

  def destroy
    @question.deleted_at = Time.now
    return render json: @question.errors, status: :internal_server_error unless @question.save
    render json: @question, status: :ok
  end

  private
    def question_params
      return_params = params.require(:question).permit(:text)
      return_params[:user_id] = session[:user_id]
      return_params
    end

    def validate_question
      @question = Question.find_by(id: params[:id], user_id: session[:user_id])
      render json: { error: "You cannot perform this action" }, status: :not_found unless @question
    end
end
