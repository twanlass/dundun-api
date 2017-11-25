class ItemSerializer < ActiveModel::Serializer
  attributes :id, :idx, :title, :completed, :completed_at, :due_at, :is_event, :created_at

  belongs_to :list
end
