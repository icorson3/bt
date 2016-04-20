class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.item_array.count.to_f/sales_engine.merchants.merchant_array.count.to_f).round(2)
  end

  def

end
