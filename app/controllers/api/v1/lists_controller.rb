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
      items = current_user.lists.find(params[:id]).items
      sort_order = items.rank(:idx).ids
      badge_count = items.where(completed: false).count
      render json: current_user.lists.find(params[:id]), include: ['items'], meta: {badge_count: badge_count, num_items: sort_order.count, sort_order: sort_order}
    end

    def update
      render json: current_user.lists.find(params[:id]).update(list_params), include: []
    end

    def destroy
      render json: current_user.lists.find(params[:id]).destroy!, include: []
    end

    private
    def list_params
      params.require(:list).permit(:title, :type)
    end
  end
end
