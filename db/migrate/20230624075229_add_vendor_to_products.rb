class AddVendorToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :vendor, foreign_key: true
  end
end
