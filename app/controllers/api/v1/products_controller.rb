require 'http'

module Api 
    module V1
        class ProductsController < ApplicationController
            before_action :authorize_request

            def index 
                @products = Product.all
                render json: @products, status: :ok
            end

            def show
                @product = Product.where(:id => params[:id])
                if !@product
                    render json: "product not available", status: :not_found
                else
                    render json: @product, status: :ok
                end
            end
        end
    end
end