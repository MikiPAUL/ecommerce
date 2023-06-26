require 'rails_helper'

RSpec.describe "API::V1::Products", type: :request do

    describe "GET /products" do
        it "fails - not authorized" do
            post "/auth/login", headers: { Authorization: {}}
            expect(response.status).to eq(401)
        end

        it "accepts - authorized" do
            post "/auth/login"
            expect(response.status).to eq(200)
        end
    end
end