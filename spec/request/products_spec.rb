require 'rails_helper'

RSpec.describe "API::V1::Products", type: :request do

    let!(:vendor) { create(:vendor) }
    let!(:products) { create_list(:product, 10, :vendor_id => vendor.id) }
    let!(:customer) { create(:customer) }
    let!(:token) { authorization customer}

    describe "GET /products" do
        it "fails - not authorized" do
            get "/products", headers: { Authorzation: ""}
            expect(response.status).to eq(401)
        end

        it "accepts - authorized" do
            get "/products", headers: { Authorization: token}
            expect(response.status).to eq(200)
        end

        it 'return 10 products' do
            get '/products', headers: { :Authorization => token}
            
            expect(JSON.parse(response.body).length).to eq(10)
        end
    end
end