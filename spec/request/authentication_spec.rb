require 'rails_helper'

RSpec.describe "API::V1::Authentication", type: :request do

    context 'post /auth/signup' do
    
        it 'return 201 status - valid credentials' do
            customer_params = {
                customer: {
                    :first_name => "user",
                    :last_name => "name",
                    :email => "username@gmail.com",
                    :password => "usernamepassword"
                }
            }
            post '/auth/signup', params: customer_params
            expect(response.status).to eq(201)
        end

        it 'return 417 status - parameter missing' do
            customer_params = {
                customer: {
                    :first_name => "user",
                    :last_name => "name",
                    :email => "username@gmail.com"
                }
            }
            post '/auth/signup', params: customer_params
            expect(response.status).to eq(422)
        end

        it 'return 401 status - email already exist' do 

            customer = {
                :first_name => "customer.first_name",
                :last_name => "customer.last_name",
                :email => "customer.email",
                :password => "customer.password"
            }

            customer_params = {
                customer: customer
            }

            Customer.create!(customer)
            post '/auth/signup', params: customer_params
            expect(response.status).to eq(422)
        end
    end

    context 'post /auth/login' do
        
        let!(:customer)  { create(:customer) }

        it 'returns true - valid credentials' do
            customer_params = {
                :email => customer.email,
                :password => customer.password
            }
            post '/auth/login', params: customer_params
            expect(response.status).to eq(200)
        end

        it 'returns false - email and password not given' do
            customer_params = {}

            post '/auth/login', params: customer_params
            expect(response.status).to eq(417)
        end

        it 'returns false - email and password given but not valid' do
            customer_params = {
                :email => "randomuser",
                :password => "randompassword"
            }

            post '/auth/login', params: customer_params
            expect(response.status).to eq(401)
        end
    end
    
end