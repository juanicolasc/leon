class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.integer :item_id
      t.integer :sale_id
      t.integer :price

      t.timestamps
    end
  end
end
