class Book < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :purchase_date, presence: true
  validates :image_url, presence: true
end
