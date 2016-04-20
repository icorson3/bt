class Merchant
attr_reader :id, :name, :merchant_array
  def initialize(merchant_hash, merchant_array = nil)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @merchant_array = merchant_array
  end

  def items
    merchant_array.sales_engine.items.find_all_by_merchant_id(id)
  end


end
