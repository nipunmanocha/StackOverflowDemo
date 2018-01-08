class AnswersController < ApplicationController
    def create
        @answer = Answer.new
        format.js
    end
end
