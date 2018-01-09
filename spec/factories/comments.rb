FactoryBot.define do
    factory :question_comment, class: "Comment" do |f|
        f.text { Faker::Simpsons.quote }
        f.user

        f.association :commentable, factory: :question
    end

    factory :answer_comment, class: "Comment" do |f|
        f.text { Faker::Simpsons.quote }
        f.user

        f.association :commentable, factory: :answer
    end
end
