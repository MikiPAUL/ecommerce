class CartSerializer < ActiveModel::Serializer
  has_many :products
  attributes :cart_id

  def cart_id
    return object.id
  end
end
