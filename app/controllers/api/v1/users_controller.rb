module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user, only: [:show, :update]

    def create
      user = User.create!(user_create_params)

      # Create the default today, upcoming, etc lists
      user.lists.create_default_lists()
      render json: user
    end

    def update
      render json: current_user.update!(user_update_params)
    end

    def show
      render json: current_user
    end

    private
    def user_create_params
      params.require(:user).permit(:email, :password, :timezone)
    end

    def user_update_params
      params.permit(:timezone)
    end
  end
end
