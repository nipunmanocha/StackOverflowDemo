class AnswersController < ApplicationController
    before_action :validate_answer, only: [:update, :destroy]

    def index
        @answers = Answer.active

        @answers = @answers.where(user_id: params[:user_id]) if params[:user_id]
        @answers = @answers.where(question_id: params[:question_id]) if params[:question_id]

        render json: {
            answers: @answers
        }
    end

    def create
        @answer = Answer.new(answer_params)
        return render json: @answer.errors, status: 500 unless @answer.save
        render json: @answer, status: 201
    end

    def update
        return render json: @answer.errors, status: 500 unless @answer.update_attributes(answer_update_params)
        render json: @answer, status: 200
    end

    def destroy
        @answer.deleted_at = Time.now
        return render json: @answer.errors, status: 500 unless @answer.save
        render json: @answer, status: 201
    end

    private
        def answer_params
            return_params = params.require(:answer).permit(:text, :question_id)
            return_params[:user_id] = session[:user_id]
            return_params
        end

        def answer_update_params
            params.require(:answer).permit(:text)
        end

        def validate_answer
            @answer = Answer.active.find_by(id: params[:id], user_id: session[:user_id])
            return render json: { error: "Invalid action" }, status: 404 unless @answer
        end
end