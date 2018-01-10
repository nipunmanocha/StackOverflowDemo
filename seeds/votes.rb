require_relative './iterate'

module Votes
  def self.vote (users, entities, value)
    iterate_user_entities(users, entities) do |user, entity|
        Vote.create(value: value, voteable: entity, user: user)
    end
  end

  def self.seed
    users = User.all[0..1]
    questions = Question.all[-3..-1]
    answers = Answer.all[-8..-1]
    vote(users, questions, 1)
    vote(users, answers, -1)

    users = User.all[-2..-1]
    questions = Question.all[0..2]
    answers = Answer.all[0..7]
    vote(users, questions, -1)
    vote(users, answers, 1)
  end
end
