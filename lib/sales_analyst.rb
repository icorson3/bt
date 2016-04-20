class SalesAnalyst

  attr_reader :sales_engine, :price_array

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.item_array.count.to_f/sales_engine.merchants.merchant_array.count.to_f).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    #find all items that the merchant has
    merchant_items = sales_engine.merchants.find_by_id(merchant_id).items
    @price_array = merchant_items.map do |merchant_item|
      merchant_item.unit_price
    end.reduce(:+)
    price_array/merchant_items.count
  end

  def average_average_price_for_merchant
    require "pry"; binding.pry
    average_price_each_merchant = sales_engine.merchants
    #sum unit price of merchant's items
    #divide by number of items merchant has
  end

end
