class List < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled

  validates :title, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy

  # Given a user's timezone, move any items completed yesterday to the Done list
  def self.move_items_to_done(list_id, done_list_id, timezone)
    done_items = Item.where({
      list_id: list_id,
      completed: true,
      completed_at: Date.yesterday.end_of_day.in_time_zone(timezone)
    })
    done_items.update_all(list_id: done_list_id)
  end

  # Move any upcoming items that are now due to the Today list
  def self.move_items_to_today(today_list_id, upcoming_list_id)
    due_items = Item.where({
      list_id: upcoming_list_id,
      due_at: Date.today.beginning_of_day..Date.today.end_of_day
    })
    due_items.update_all(list_id: today_list_id)
  end
end
