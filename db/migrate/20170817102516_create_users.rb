class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password, :null => false
      t.string :token, :null => false

      t.timestamps
    end
  end
end
