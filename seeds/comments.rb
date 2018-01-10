require_relative './iterate'

module Comments
  def self.comment (users, entities)
    iterate_user_entities(users, entities) do |user, entity|
        Comment.create(
            text: "This is #{user[:name]}'s comment on #{entity.class} no: #{entity[:id]}", 
            commentable: entity, 
            user: user
        )
    end
  end

  def self.seed
    users = User.all[0..1]
    questions = Question.all[-3..-1]
    answers = Answer.all[-8..-1]
    comment(users, questions)
    comment(users, answers)

    users = User.all[-2..-1]
    questions = Question.all[0..2]
    answers = Answer.all[0..7]
    comment(users, questions)
    comment(users, answers)
  end
end
