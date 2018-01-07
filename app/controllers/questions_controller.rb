class QuestionsController < ApplicationController
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
    @question = Question.find(params[:id])
    @answers = @question.answers
  end

  private
  def question_params
    return_params = params.require(:question).permit(:text)
    return_params[:user_id] = session[:user_id]
    return_params
  end
end
