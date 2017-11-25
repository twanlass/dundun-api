class Item < ActiveRecord::Base
  include RankedModel
  ranks :idx, :with_same => :list_id

  validates :title, presence: true
  validates :list_id, presence: true
  before_save :default_due_at

  belongs_to :list

  def default_due_at
    self.due_at ||= Time.now.to_i
  end
end
