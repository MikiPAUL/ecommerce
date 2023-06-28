require 'rails_helper'

RSpec.describe "API::V1::Product", type: :request do

    let!(:vendor) { create(:vendor) }
    let!(:products) { create_list(:product, 10, :vendor_id => vendor.id) }
    let!(:customer) { create(:customer) }
    let!(:token) { authorization customer}

    context 'post /carts' do
        
        it 'returns 201 - create cart' do
            products_list = {
                :products => products.map { |product|
                    { "id" => product["id"] }
                }
            }
            post '/carts', headers: { :Authorization => token }, params: products_list, as: :json
            expect(JSON.parse(response.body).length).to eq(10) and expect(response.status).to eq(201)
        end

        it 'return 411- not enough product to create cart' do 
            post '/carts', headers: { :Authorization => token }, params: {}, as: :json
            expect(response.status).to eq(422)
        end
    end

    context 'update /carts' do
        
        it 'returns 404 - cart not found' do
            products_list = {
                :products => products.map { |product|
                    { "id" => product["id"] }
                }
            }
            put '/carts?cart_id=9999', headers: { :Authorization => token }, params: products_list, as: :json
            expect(response.status).to eq(404)
        end
    end

    context 'destroy /cart/:id' do
        
        it 'returns 404 - cart not found' do
            delete '/carts/999', headers: { :Authorization => token }, as: :json
            expect(response.status).to eq(404)
        end
    end
end