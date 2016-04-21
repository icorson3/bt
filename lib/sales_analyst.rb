require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.item_array.count.to_f/sales_engine.merchants.merchant_array.count.to_f).round(2)
    #sales engine should have method that will grab number of items in it.
    #items should have method that returns count within item
  end

  def average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    number_items_array = sales_engine.merchants.merchant_array.map do |merchant|
      merchant.items.count
    end
    sample_variance = number_items_array.reduce(0) do |total,merchant_avg|
      total + ((merchant_avg - avg) ** 2)
    end/(number_items_array.length - 1).to_f

    Math.sqrt(sample_variance).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = sales_engine.merchants.find_by_id(merchant_id).items
    price_array = merchant_items.map do |merchant_item|
      merchant_item.unit_price
    end.reduce(:+)
    (price_array/merchant_items.count).round(2)
  end

  def merchants_with_high_item_count
    std_deviation = average_items_per_merchant_standard_deviation
    high_item_count = average_items_per_merchant + std_deviation
    sales_engine.merchants.merchant_array.find_all do |merchant|
      merchant.items.length > high_item_count
    end
  end

  def average_average_price_per_merchant
    total_sum_average_shop_prices = sales_engine.merchants.merchant_array.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (total_sum_average_shop_prices/sales_engine.merchants.merchant_array.count).round(2)
  end

  def average_item_price_standard_deviation
    avg = average_average_price_per_merchant
    unit_price_array = sales_engine.items.item_array.map do |item|
      item.unit_price
    end
    sample_variance = unit_price_array.reduce(0) do |total,price_avg|
      total + ((price_avg - avg) ** 2)
    end/(unit_price_array.length - 1).to_f

    Math.sqrt(sample_variance).round(2)
  end

  def golden_items
    double_deviation = (average_item_price_standard_deviation * 2)
    high_price = double_deviation + average_average_price_per_merchant
    sales_engine.items.item_array.find_all do |item|
      item.unit_price > high_price
    end
  end
end
