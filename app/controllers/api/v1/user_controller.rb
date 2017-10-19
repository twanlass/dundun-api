module Api::V1
  class UserController < ApplicationController
    before_action :authenticate_user, only: [:show]

    def create
      user = User.new(user_params)
        if user.save
          render status: 200, json: { success: true}
        else
          render status: 422, json: { errors: user.errors }.to_json
        end
    end

    def show
      if current_user
        user = User.find_by_id(current_user.id)
        render status: 200, json: { user: user}.to_json
      else
        render status: 401, json: { success: false}
      end
    end

    private
    def user_params
      params.permit(:email, :password)
    end

  end
end
