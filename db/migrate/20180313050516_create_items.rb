class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :code
      t.string :brand
      t.string :name
      t.string :supplier
      t.text :description
      t.integer :price
      t.integer :cost
      t.integer :stock
      t.timestamps
    end
  end
end
