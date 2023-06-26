class Product < ApplicationRecord
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    belongs_to :vendor
end
