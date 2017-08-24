class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :price, :purchase_date
end
