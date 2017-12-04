class ItemSerializer < ActiveModel::Serializer
  attributes :id, :list_id, :idx, :title, :completed, :completed_at, :due_at, :is_event, :created_at

  belongs_to :list
end
