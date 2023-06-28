class OrderSerializer < ActiveModel::Serializer
  attributes :order_id, :delivered, :placed_date, :cart_id

  def order_id
    return object.id
  end
end
