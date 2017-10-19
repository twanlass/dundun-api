class ItemSerializer < ActiveModel::Serializer
  attributes :title
  attributes :completed
  attributes :completed_at
  attributes :due_at
  attributes :is_event
  attributes :created_at
end
