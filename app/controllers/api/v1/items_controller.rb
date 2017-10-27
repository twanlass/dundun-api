module Api::V1
  class ItemsController < ApplicationController
    before_action :authenticate_user

    def create
      render json: current_user.lists.find(params[:list_id]).items.create!(item_params)
    end

    def show
      render json: current_user.items.find(params[:id])
    end

    def update
      render json: current_user.items.find(params[:id]).update!(item_params)
    end

    def destroy
      render json: current_user.items.find(params[:id]).destroy!
    end

    private
    def item_params
      params.require(:item).permit(:title, :completed, :is_event, :due_at, :list_id)
    end
  end
end
