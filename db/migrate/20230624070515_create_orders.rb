class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.date :placed_date
      t.boolean :delivered

      t.timestamps
    end
  end
end
