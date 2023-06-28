require 'rails_helper'

RSpec.describe Customer, type: :model do
    context 'null tests' do
        let!(:customer) { build(:customer) }

        it 'return false - first_name is null' do
            customer.first_name = nil
            expect(customer.save).to eq(false)
        end

        it 'return false - last_name is null' do
            customer.last_name = nil
            expect(customer.save).to eq(false)
        end

        it 'return false - email is null' do
            customer.email = nil
            expect(customer.save).to eq(false)
        end

        it 'return false - password is null' do 
            customer.password = nil
            expect(customer.save).to eq(false)
        end
    end

    context 'uniqueness test' do
        let!(:customers) { build_list(:customer, 2, email: "username@gmail.com") }

        it 'return false - email is not unique' do
            is_unique = true
            customers.each { |customer|
                is_unique = false if !customer.save
            }
            expect(is_unique).to eq(false)
        end
    end
end