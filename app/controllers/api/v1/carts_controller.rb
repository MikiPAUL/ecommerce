module Api 
    module V1
        class CartsController < ApplicationController
             before_action :authorize_request

            def index 
                @customer = user_info
                @carts = Cart.where(:customer_id => @customer.id)

                if !@carts
                    render json: "no cart created yet", status: :not_found
                else 
                    render json: @carts ,status: :ok
                end
            end

            def show
                @customer = user_info
                @customer_cart = Cart.where("customer_id = ? and id = ?", @customer.id, params[:id])
                if @customer_cart
                    render json: @customer_cart, status: :ok
                else 
                    render json: "not found", status: :not_found
                end 
            end

            def create
                @customer = user_info

                @cart = Cart.new
                @cart.customer_id = @customer.id
                @cart.save

                @products = params[:products]
                @products.each { |product|
                    CartProduct.create!(cart_id: @cart.id, product_id: product[:id])
                }
                render json: @products, status: :created
            end 

            def update
                @customer = user_info
                @customer_cart = Cart.where("customer_id = ? and id = ?", @customer.id, params[:cart_id])

                if !@customer_cart
                    render json: "cart doesn't exist", status: :unprocessable_entity
                else 
                    @products = params[:products]
                    @products.each { |product|
                        CartProduct.create!(:cart_id => params[:cart_id], :product_id => product[:id])
                    }
                    render json: @products, status: :ok
                end
            end

            def destroy
                @cart = Cart.where(:id => params[:id]).last
                if !@cart
                    render json: "cart not found", status: :not_found 
                else 
                    @cart.destroy
                    render json: "deleted successfully", status: :ok
                end
            end

            private

            def cart_params
                params.permit(:id, products: [])
            end

        end
    end
end