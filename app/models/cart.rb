class Cart < ApplicationRecord
    belongs_to :customer 
    has_one :order, dependent: :destroy
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
end
