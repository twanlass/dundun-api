module Api::V1
  class ListsController < ApplicationController

    def index
      render status: 200, json: { lists: true}
    end

  end
end
