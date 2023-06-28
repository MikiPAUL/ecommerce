FactoryBot.define do 
    factory :vendor do
        company_name { Faker::Lorem.word }
        phone { Faker::PhoneNumber.phone_number }
        email { Faker::Internet.email }
    end
end