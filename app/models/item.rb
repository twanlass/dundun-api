class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :completed, inclusion: [true, false]
  validates :is_event, inclusion: [true, false]
  # todo: Validate completed at is a date
end
