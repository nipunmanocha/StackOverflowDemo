FactoryBot.define do
    factory :answer do |f|
        f.text { Faker::HarryPotter.quote }
        f.question
        f.user
    end
end
