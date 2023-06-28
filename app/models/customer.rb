class Customer < ApplicationRecord
    has_secure_password
    has_many :carts, dependent: :destroy

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
