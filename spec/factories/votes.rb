FactoryBot.define do
    factory :question_vote, class: "Vote" do |f|
        f.value { [1, -1].sample }
        f.user

        f.association :voteable, factory: :question
    end

    factory :answer_vote, class: "vote" do |f|
        f.value { [1, -1].sample }
        f.user

        f.association :voteable, factory: :answer
    end
end
