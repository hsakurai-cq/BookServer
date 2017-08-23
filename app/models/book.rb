class Book < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :price, presence: true
  validates :purchase_date, presence: true
  validates :image, presence: true
end
