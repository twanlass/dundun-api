module Api::V1
  class ItemsController < ApplicationController
    before_action :authenticate_user
    wrap_parameters include: [:idx_position, :title, :completed, :is_event, :due_at, :list_id]

    def create
      item = current_user.lists.find(params[:list_id]).items.create!(item_params)
      render json: item,
      include: [],
      meta: {list_id: item.list_id}
    end

    def show
      render json: current_user.items.find(params[:id]), include: []
    end

    def update
      render json: current_user.items.find(params[:id]).update!(item_params), include: []
    end

    def destroy
      render json: current_user.items.find(params[:id]).destroy!, include: []
    end

    private
    def item_params
      params.require(:item).permit(:idx_position, :title, :completed, :is_event, :due_at, :list_id)
    end
  end
end
