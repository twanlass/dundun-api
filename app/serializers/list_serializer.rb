class ListSerializer < ActiveModel::Serializer
  attributes :title, :id, :type, :created_at

  has_many :items
  belongs_to :user

  # Return list items with item id as key for easier use with Redux
  def items
    items = object.items.rank(:idx).map { |i| [i.id, i] }.to_h
  end
end
