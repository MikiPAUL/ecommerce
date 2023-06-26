module UserConcern extend ActiveSupport::Concern 

    def user_info
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        @decoded = JsonWebToken.decode(header)
        @current_customer = Customer.find(@decoded[:customer_id])
        return @current_customer
    end
end
