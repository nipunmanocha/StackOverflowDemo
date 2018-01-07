class QuestionsController < ApplicationController
  before_action :validate_question, only: [:update, :destroy]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question created successfully.."
      redirect_to User.find_by(id: session[:user_id])
    else
      render 'new'
    end
  end

  def show
    @question = Question.active.find(params[:id])
    @answers = @question.answers
  end

  def update
    return render json: @question.errors, status: 500 unless @question.update_attributes(question_params)
    render json: @question, status: 200
  end

  def destroy
    @question.deleted_at = Time.now
    return render json: @question.errors, status: 500 unless @question.save
    render json: @question, status: 201
  end

  private
  def question_params
    return_params = params.require(:question).permit(:text)
    return_params[:user_id] = session[:user_id]
    return_params
  end

  def validate_question
    @question = Question.active.find_by(id: params[:id], user_id: session[:user_id])
    render json: { error: "You cannot perform this action" }, status: 404 unless @question
  end
end
