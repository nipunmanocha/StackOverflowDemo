class StaticPagesController < ApplicationController
  def home
    @top_questions = Question.active.order(id: :desc).limit(10)
  end
end
