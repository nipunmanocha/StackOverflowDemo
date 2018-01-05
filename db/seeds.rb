# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

users_list = [
    { name: "Nipun Manocha", email: "nipun.manocha@1mg.com", password: "123456" },
    { name: "Kartik", email: "kartik.arora@1mg.com"},
    { name: "Himanshu", email: "himanshu@1mg.com", password: "983737" },
    { name: "Viren", email: "viren@1mg.com", password: "222222", salt: "dsdcs334vv" }
]
users_list.each { |user| User.create(user) }

users = User.all

users.each do |user|
    2.times do |i|
        Question.create(text: "#{user[:name]}'s Question number #{i + 1}", user: user)
    end
end

questions = Question.all

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
