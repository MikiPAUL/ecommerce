class ProductSerializer < ActiveModel::Serializer
  attributes :product_id, :price, :category, :available

  def product_id
    return object.id
  end
end
