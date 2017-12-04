class List < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled

  validates :title, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy

  def self.move_items_to_done(list_id, done_list_id)
    done_items = Item.where("list_id = ? AND completed = true AND completed_at <= ?", list_id, Date.yesterday.end_of_day)
    done_items.update_all(list_id: done_list_id)
  end

  def self.move_items_to_today(today_list_id, upcoming_list_id)
    due_items = Item.where(list_id: upcoming_list_id).where(due_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    due_items.update_all(list_id: today_list_id)
  end
end
