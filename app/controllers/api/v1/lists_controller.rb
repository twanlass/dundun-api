module Api::V1
  class ListsController < ApplicationController
    before_action :authenticate_user

    def index
      lists = current_user.lists
      core_lists = lists.where(type: 'core').order(:created_at).ids
      custom_lists = lists.where(type: 'custom').order(:created_at).ids
      sort_order = core_lists + custom_lists
      render json: {lists: lists.map { |i| [i.id, i] }.to_h, meta: {sort_order: sort_order, num_lists: sort_order.count}}
    end

    def create
      render json: current_user.lists.create!(list_params), include: []
    end

    def show
      show_list(current_user.lists.find(params[:id]))
    end

    def update
      render json: current_user.lists.find(params[:id]).update(list_params), include: []
    end

    def destroy
      render json: current_user.lists.find(params[:id]).destroy!, include: []
    end

    def named_list
      # Allow lookup of core lists by name instead of id (today, upcoming, someday and done)
      show_list(current_user.lists.find_by(title: params[:id]))
    end

    private
    def list_params
      params.require(:list).permit(:title, :type)
    end

    def show_list(list)
      # Given a user's timezone, move any items completed yesterday to the Done list
      done_list = current_user.lists.find_by(title: 'done')
      List.move_items_to_done(done_list.id, current_user.timezone)

      # Move any upcoming items that are now due to the Today list
      today_list = current_user.lists.find_by(title: 'today')
      upcoming_list = current_user.lists.find_by(title: 'upcoming')
      List.move_items_to_today(today_list.id, upcoming_list.id)

      # Fetch list items after any move actions above
      items = list.items

      # Meta data for list
      sort_order = items.rank(:idx).ids
      badge_count = items.where(completed: false).count

      render json: list,
      include: ['items'],
      meta: {
        badge_count: badge_count,
        num_items: sort_order.count,
        sort_order: sort_order
      }
    end
  end
end
