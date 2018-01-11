module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: { head: :not_found }
    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: exception, status: :bad_request 
    end
  end
end
