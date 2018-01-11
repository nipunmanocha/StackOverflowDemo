class V1::StaticPagesController < ApplicationController
  def home
    @top_questions = Question.order(id: :desc).limit(10)
  end
end
