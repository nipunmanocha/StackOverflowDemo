FactoryBot.define do
    factory :question do |f|
        f.text { Faker::HarryPotter.book }
        f.user
    end
end