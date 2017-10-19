module Api::V1
  class ItemsController < ApplicationController
    before_action :authenticate_user

    # Todo: only allow actions on user owned items:
    # @item = current_user.items.find_by_id(params[:id])
    # If it returns anything, great. If not, not owned, return 404

    def index
      @items = Item.all
      if @items
        render status: 200, json: @items
      else
        render status: 404
      end
    end

    def create
      @item = Item.new(item_params)
      if @item.save
        render status: 200, json: @item
      else
        render status: 422, json: @item.errors
      end
    end

    def show
      @item = Item.find_by_id(params[:id])
      if @item
        render status: 200, json: @item
      else
        render status: 404
      end
    end

    def update
      @item = Item.find_by_id(params[:id])
      if @item
        if @item.update(item_params)
          render status: 200, json: @item
        else
          render status: 422, json: @item.errors
        end
      else
        render status: 404
      end
    end

    def destroy
      @item = Item.find_by_id(params[:id])
      if @item
        if @item.destroy
          render status: 200, json: @item
        else
          render status: 422, json: @item.errors
        end
      else
        render status: 404
      end
    end

    private
    def item_params
      params.require(:item).permit(:title, :completed, :is_event, :due_at)
    end
  end
end
