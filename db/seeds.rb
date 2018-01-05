# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

def iterate_user_entities (users, entities)
    users.each do |user|
        entities.each do |entity|
            yield(user, entity)
        end
    end
end

def vote (users, entities, value)
    iterate_user_entities(users, entities) do |user, entity|
        Vote.create(value: value, voteable: entity, user: user)
    end
end

def comment (users, entities)
    iterate_user_entities(users, entities) do |user, entity|
        Comment.create(
            text: "This is #{user[:name]}'s comment on #{entity.class} no: #{entity[:id]}", 
            commentable: entity, 
            user: user
        )
    end
end

# Seeds for creating users
users_list = [
    { name: "Nipun Manocha", email: "nipun.manocha@1mg.com", password: "123456" },
    { name: "Kartik", email: "kartik.arora@1mg.com"},
    { name: "Himanshu", email: "himanshu@1mg.com", password: "983737" },
    { name: "Viren", email: "viren@1mg.com", password: "222222", salt: "dsdcs334vv" }
]
users_list.each { |user| User.create(user) }
users = User.all

# Seeds for creating questions
users.each do |user|
    2.times do |i|
        Question.create(text: "#{user[:name]}'s Question number #{i + 1}", user: user)
    end
end
questions = Question.all

# Seeds for creating answers
users.each do |user|
    questions.each do |question|
        unless question[:user_id] == user[:id]
            Answer.create(
                text: "This is #{user[:name]}'s answer to question #{question[:text]}", 
                question: question, 
                user: user
            )
        end
    end
end
answers = Answer.all

# Seeds for creating votes and comments
# first two users upvoting last 3 question and downvoting last 8 answers and commenting on them
users_temp = users[0..1]
questions_temp = questions[-3..-1]
answers_temp = answers[-8..-1]
vote(users_temp, questions_temp, 1)
vote(users_temp, answers_temp, -1)
comment(users_temp, questions_temp)
comment(users_temp, answers_temp)

# last two users downvoting first 3 questions and upvoting first 8 answers and commenting on them
users_temp = users[-2..-1]
questions_temp = questions[0..2]
answers_temp = answers[0..7]
vote(users_temp, questions_temp, -1)
vote(users_temp, answers_temp, 1)
comment(users_temp, questions_temp)
comment(users_temp, answers_temp)

10.times { |i| Tag.create(value: "Tag #{i + 1}", description: "This is tag number #{i + 1}") }
tags = Tag.all

questions_temp = questions[0..4]
tags_temp = tags[0..5]

questions_temp.each do |question|
    question.tags = tags_temp
end
