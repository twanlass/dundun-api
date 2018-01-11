class List < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled

  validates :title, presence: true

  belongs_to :user
  has_many :items, dependent: :destroy

  # Given a user's timezone, move any items recently completed to the Done list
  def self.move_items_to_done(done_list_id, timezone)
    Time.use_zone(timezone) do
      logger.info '--------------------------------'
      logger.info "Move items to done with timezone: #{timezone}"
      logger.info "Time.at(0).to_datetime: #{Time.at(0).to_datetime}"
      logger.info '--------------------------------'
      done_items = Item.where.not(list_id: done_list_id).where({
        completed: true,
        completed_at: (Time.at(0).to_datetime..Time.zone.yesterday.end_of_day)
      })
      done_items.update_all(list_id: done_list_id)
    end
  end

  # Given a user's timezone, move any upcoming items that are now due to the Today list
  def self.move_items_to_today(today_list_id, upcoming_list_id, timezone)
    Time.use_zone(timezone) do
      logger.info '--------------------------------'
      logger.info "Move items to today with timezone: #{timezone}"
      logger.info "beginning_of_day: #{Date.today.beginning_of_day}"
      logger.info '--------------------------------'
      due_items = Item.where({
        list_id: upcoming_list_id,
        due_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
      })
      due_items.update_all(list_id: today_list_id)
    end
  end

  # Create the default lists for new users
  def self.create_default_lists
    self.create([
      {title: 'today', type: 'core'},
      {title: 'upcoming', type: 'core'},
      {title: 'someday', type: 'core'},
      {title: 'done', type: 'core'}
    ])
  end
end
