module Api::V1
  class ListsController < ApplicationController
    before_action :authenticate_user

    def index
      render json: current_user.lists.all
    end

    def create
      render json: current_user.lists.create!(list_params)
    end

    def show
      render json: current_user.lists.find(params[:id]), include: ['items']
    end

    def update
      render json: current_user.lists.find(params[:id]).update(list_params)
    end

    def destroy
      render json: current_user.lists.find(params[:id]).destroy!
    end

    private
    def list_params
      params.require(:list).permit(:title)
    end
  end
end
