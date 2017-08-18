class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :price
      t.datetime :purchase_date
      t.string :image_url
      t.integer :user_id

      t.timestamps
    end
  end
end
