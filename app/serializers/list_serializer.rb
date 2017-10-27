class ListSerializer < ActiveModel::Serializer
  attributes :title, :id

  has_many :items
  belongs_to :user
end
