class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.float :price
      t.string :category
      t.boolean :available

      t.timestamps
    end
  end
end
