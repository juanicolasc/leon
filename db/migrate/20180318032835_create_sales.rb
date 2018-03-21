class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.date :date
      t.string :customer_name
      t.string :customer_identification
      t.bigint :customer_phone
      t.integer :total_charge
      t.integer :number_of_items
      t.string :payment_method
      t.text :comments
      t.integer :user_id

      t.timestamps
    end
  end
end
