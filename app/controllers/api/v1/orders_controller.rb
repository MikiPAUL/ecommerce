module Api 
    module V1
        class OrdersController < ApplicationController
             before_action :authorize_request

            def create
                @customer = user_info
                @order = Order.new(order_params)
                
                if @order.save
                    render json: @order, status: :created
                else 
                    render json: "unable to add order", status: :unprocessable_entity
                end
            end 

            private

            def order_params
                params.require(:order).permit(:placed_date, :delivered, :cart_id)
            end
        end
    end
end