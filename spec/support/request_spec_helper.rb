module AuthorizationSpecHelper
    def authorization customer
        post '/auth/login', params: {email: customer.email, password: customer.password}, as: :json

        token = JSON.parse(response.body)["token"]

        return token
    end
end