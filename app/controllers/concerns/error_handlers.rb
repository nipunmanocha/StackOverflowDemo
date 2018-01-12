module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      head :not_found
    end
    
    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: exception, status: :bad_request 
    end
  end
end
