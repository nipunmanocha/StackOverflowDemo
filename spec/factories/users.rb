FactoryBot.define do
    fake_password = Faker::Internet.password

    factory :user do |f|
       f.name { Faker::HarryPotter.character }
       f.email { Faker::Internet.email }
       f.password fake_password
       f.password_confirmation fake_password
    end
end
