class V1::AnswersController < ApplicationController
  before_action :require_login, only: [:create, :update, :delete]

  def index
    render json: answers.where(question_id: params[:question_id]), status: :ok
  end

  def show
    render json: Answer.find(params[:id]), status: :ok
  end

  def create
    render json: answers.where(question_id: params[:question_id]).create!(answer_params), status: :created
  end

  def update
    answer.update!(answer_params)
    render json: answer, status: :ok
  end

  def destroy
    answer.destroy!
    head :ok
  end

  private
    def answer_params
      params.require(:answer).permit(:text)
    end

    def answers
      current_user.answers
    end

    def answer
      answers.find(params[:id])
    end
end
