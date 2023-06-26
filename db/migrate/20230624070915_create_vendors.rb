class CreateVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.string :company_name
      t.string :phone
      t.string :email
      
      t.timestamps
    end
  end
end
