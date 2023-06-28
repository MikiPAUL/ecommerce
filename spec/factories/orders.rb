FactoryBot.define do
    factory :order do
        placed_date { "2023-06-23" }
        delivered { true }
        cart
    end
end