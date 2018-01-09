FactoryBot.define do
    factory :answer do |f|
        f.text { Faker::HarryPotter.quote }
        question
        user
    end
end
