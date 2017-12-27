module Api::V1
  class UserController < ApplicationController
    before_action :authenticate_user, only: [:show]

    def create
      user = User.create!(user_params)
      # Create the default today, upcoming, etc lists
      user.lists.create_default_lists()
      render json: user
    end

    def show
      user = User.find(current_user.id)
      render json: user
    end

    private
    def user_params
      params.permit(:email, :password)
    end
  end
end
