class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name, :null => false
      t.integer :price, :null => false
      t.datetime :purchase_date, :null => false
      t.string :image_url, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
