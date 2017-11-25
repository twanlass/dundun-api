module Api::V1
  class ListsController < ApplicationController
    before_action :authenticate_user

    def index
      render json: current_user.lists.all, include: []
    end

    def create
      render json: current_user.lists.create!(list_params), include: []
    end

    def show
      sort_order = current_user.lists.find(params[:id]).items.rank(:idx).ids
      render json: current_user.lists.find(params[:id]), include: ['items'], meta: {sort_order: sort_order}
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
