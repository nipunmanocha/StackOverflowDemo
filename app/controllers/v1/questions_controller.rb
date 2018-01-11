class V1::QuestionsController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  def index
    render json: questions, status: :ok
  end

  def show
    render json: Question.find(params[:id]), status: :ok
  end

  def create
    render json: questions.create!(question_params), status: :created
  end

  def update
    question.update!(question_params)
    render json: question, status: :ok
  end

  def destroy
    question.destroy!
    head :ok
  end

  private
    def question_params
      params.require(:question).permit(:text)
    end

    def questions
      current_user.questions
    end

    def question
      questions.find(params[:id])
    end
end
