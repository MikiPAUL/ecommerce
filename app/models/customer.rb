class Customer < ApplicationRecord
    has_secure_password
    has_many :carts, dependent: :destroy
end
