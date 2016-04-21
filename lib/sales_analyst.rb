require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.item_count.to_f/sales_engine.merchant_count.to_f).round(2)
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
    #quick ways of returning arrays of merchants of merchants and items--all merchants and all items and all invoices on sales engine
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = sales_engine.find_items_by_merchant_id(merchant_id)

    price_array = merchant_items.map do |merchant_item|
      merchant_item.unit_price
    end.reduce(:+)

    (price_array/merchant_items.count).round(2)
  end

  def merchants_with_high_item_count
    high_item_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    sales_engine.merchant_repository.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def average_average_price_per_merchant
    total_sum_average_shop_prices = sales_engine.merchant_repository.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (total_sum_average_shop_prices/sales_engine.merchant_count).round(2)
  end

  def average_item_price_standard_deviation
    avg = average_average_price_per_merchant

    sample_variance = prices.reduce(0) do |total,price_avg|
      total + ((price_avg - avg) ** 2)
    end/(prices.length - 1).to_f

    Math.sqrt(sample_variance).round(2)
  end

  def prices
    sales_engine.item_repository.map do |item|
      item.unit_price
    end
  end

  def golden_items
    double_deviation = (average_item_price_standard_deviation * 2)
    high_price = double_deviation + average_average_price_per_merchant
    sales_engine.item_repository.find_all do |item|
      item.unit_price > high_price
    end
  end
end
