class Customer
attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :customer_array
  def initialize(customer_hash, customer_array = nil)
    @id = customer_hash[:id]
    @first_name = customer_hash[:first_name]
    @last_name = customer_hash[:last_name]
    @created_at = customer_hash[:created_at]
    @updated_at = customer_hash[:updated_at]
    @customer_array = customer_array
  end

  def merchants
    customer_array.find_merchants_by_customer_id(self.id)
  end
end
