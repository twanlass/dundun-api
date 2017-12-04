class Item < ActiveRecord::Base
  include RankedModel
  ranks :idx, :with_same => :list_id

  validates :title, presence: true
  validates :list_id, presence: true
  before_save :set_due_at
  before_save :set_completed_at

  belongs_to :list

  def set_due_at
    self.due_at ||= DateTime.now
  end

  def set_completed_at
    self.completed_at = self.completed ? DateTime.now : nil
  end
end
