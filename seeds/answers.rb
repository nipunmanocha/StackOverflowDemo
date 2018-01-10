require_relative './iterate'

module Answers
  def self.seed
    users = User.all
    questions = Question.all
    iterate_user_entities(users, questions) do |user, question|
      next if question[:user_id] == user[:id]
      Answer.create(
          text: "This is #{user[:name]}'s answer to question #{question[:text]}", 
          question: question, 
          user: user
      )
    end
  end
end
