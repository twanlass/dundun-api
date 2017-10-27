class ApplicationController < ActionController::API
  include Knock::Authenticable
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private
  def record_not_found
    render status: 404, json: {errors: [ {status: 404, title: "item not found"} ]}
  end

  def record_invalid(exception)
    logger.info exception
    render status: 422, json: {errors: [ {status: 422, title: exception} ]}
  end
end
