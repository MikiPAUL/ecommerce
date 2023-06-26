require 'json'

module Api
    module V1
        class AuthenticationsController < ApplicationController
            rescue_from ActionController::ParameterMissing do |e|
                render json: {"errors": e.message}, status: :expectation_failed
            end
            
            def login  
                login_params
                @customer = Customer.find_by_email(params[:email])
                if @customer&.authenticate(params[:password])
                    token = JsonWebToken.encode(customer_id: @customer.id)
                    time = Time.now + 24.hours.to_i
                    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                                    username: @customer.first_name }, status: :ok
                else
                    render json: { error: 'unauthorized' }, status: :unauthorized
                end
            end

            def signup 
                @customer = Customer.new(customer_params)
                @customer_exist = Customer.find_by_email(params[:email])
                if (!@customer_exist and @customer.save)
                    token = JsonWebToken.encode(customer_id: @customer.id)
                    time = Time.now + 24.hours.to_i
                    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                                username: @customer.first_name }, status: :created
                else
                    render json: "couldn't able to create account",
                        status: :unprocessable_entity
                end
            end 

            private

            def login_params
                params.require([:email, :password])
            end

            def customer_params
                params.require(:customer).permit(
                  :first_name, :last_name, :email, :password
                )
            end
        end
    end
end
