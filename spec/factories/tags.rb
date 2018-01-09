FactoryBot.define do
    factory :tag do |f|
        f.value { Faker::Music.instrument }
        f.description { Faker::Movie.quote }
    end
end
