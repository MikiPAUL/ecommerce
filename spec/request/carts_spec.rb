require 'rails_helper'

RSpec.describe "API::V1::Authentication", type: :request do

    describe "GET /login" do
        it "fails - no credentials" do
            post "/auth/login"
            expect(response.status).to eq(417)
        end

        it "accepts - valid credentials" do
            params = {
                :email => "abc@gmail.com", 
                :password => "1234567890"
            }
            post "/auth/login", params: params
            expect(response.status).to eq(200)
        end
    end

    describe "POST /signup" do
        it "fails - invalid attribute city" do
            params = {
                :first_name => "user",
                :city => "city",
                :email => "abc@gmail.com", 
                :password => "1234567890"
            }
            post "/auth/signup", params: params
            expect(response.status).to eq(417)
        end
        it "accepts - valid details" do
            params = { 
                    :customer => {
                    :first_name => "user",
                    :last_name => "name",
                    :email => "abc@gmail.com", 
                    :password => "1234567890"
                }
            }
            post "/auth/signup", params: params
            expect(response.status).to eq(201)
        end
    end
end