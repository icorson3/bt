class Merchant
attr_reader :id, :name, :merchant_array
  def initialize(merchant_hash, merchant_array = nil)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @merchant_array = merchant_array
  end


  def items
    merchant_array.find_items_by_merchant_id(self.id)
  end

  def invoices
    merchant_array.find_invoices_by_merchant_id(self.id)
  end

  def customers
    merchant_array.find_customers_by_merchant_id(self.id)
  end

end
