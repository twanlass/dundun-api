class List < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled

  validates :title, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy

  # Given a user's timezone, move any items recently completed to the Done list
  def self.move_items_to_done(done_list_id, timezone)
    Time.use_zone(timezone) do
      done_items = Item.where.not(list_id: done_list_id).where({
        completed: true,
        completed_at: (Time.at(0).to_datetime..Date.yesterday.end_of_day)
      })
      done_items.update_all(list_id: done_list_id)
    end
  end

  # Given a user's timezone, move any upcoming items that are now due to the Today list
  def self.move_items_to_today(today_list_id, upcoming_list_id, timezone)
    Time.use_zone(timezone) do
      due_items = Item.where({
        list_id: upcoming_list_id,
        due_at: Date.today.beginning_of_day..Date.today.end_of_day
      })
      due_items.update_all(list_id: today_list_id)
    end
  end
end
