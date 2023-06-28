FactoryBot.define do 
    categories = [ "medicine", "travel", "game", "food", "entertainment"]
    factory :product do
        price { Faker::Number.decimal(:l_digits => 2, :r_digits => 2) }
        category { Faker::Lorem.word }
        available { Faker::Boolean.boolean }
        vendor
    end
end