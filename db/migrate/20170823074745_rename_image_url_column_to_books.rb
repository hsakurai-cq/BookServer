class RenameImageUrlColumnToBooks < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :image_url, :image
  end
end
