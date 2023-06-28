class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    include UserConcern


    def not_found
        render json: { error: 'not_found' }
    end
    
    def authorize_request
        header = request.headers['Authorization']
        begin
            @decoded = JsonWebToken.decode(header) 
            @current_customer = Customer.find(@decoded[:customer_id]) 
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized
        end
    end
end
