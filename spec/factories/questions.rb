FactoryBot.define do
    factory :question do
        text 'This is a test question'
        duplicate_id nil
        wiki false
        user
    end
end