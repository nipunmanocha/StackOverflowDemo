class V1::AnswersController < ApplicationController
    before_action :validate_answer, only: [:update, :destroy]

    def index
        @answers = Answer.all
        @answers = @answers.where(user_id: params[:user_id]) if params[:user_id]
        @answers = @answers.where(question_id: params[:question_id]) if params[:question_id]
        render json: @answers, status: :ok
    end

    def show
        @answer = Answer.find(params[:id])
        render json: @answer, status: :ok
    end

    def create
        return render json: { redirect_url: signup_path }, status: :forbidden unless answer_params[:user_id]
        @answer = Answer.new(answer_params)
        return render json: @answer.errors, status: :unprocessable_entity unless @answer.save
        render json: @answer, status: :created
    end

    def update
        return render json: @answer.errors, status: :unprocessable_entity unless @answer.update_attributes(answer_update_params)
        render json: @answer, status: :ok
    end

    def destroy
        @answer.deleted_at = Time.now
        return render json: @answer.errors, status: :unprocessable_entity unless @answer.save
        render json: @answer, status: :ok
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
            @answer = Answer.find_by(id: params[:id], user_id: session[:user_id])
            return render json: { error: "Invalid action" }, status: :not_found unless @answer
        end
end
