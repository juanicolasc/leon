class AddGenderToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :gender, :string
  end
end
