module Api::V1
  class ItemsController < ApplicationController

    def index
      render status: 200, json: { items: true}
    end

  end
end
