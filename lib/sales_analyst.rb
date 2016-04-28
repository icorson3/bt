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

    standard_deviation(sample_variance)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = sales_engine.find_items_by_merchant_id(merchant_id)

    price_array = merchant_items.map do |merchant_item|
      merchant_item.unit_price
    end.reduce(:+)

    (price_array/merchant_items.count).round(2)
  end

  def merchants_with_high_item_count
    aipm = average_items_per_merchant
    aipmsd = average_items_per_merchant_standard_deviation
    high_item_count = aipm + aipmsd
    sales_engine.merchant_repository.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def average_average_price_per_merchant
    sum_average_shop_prices = sales_engine.merchant_repository.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (sum_average_shop_prices/sales_engine.merchant_count).round(2)
  end

  def average_item_price_standard_deviation
    avg = average_average_price_per_merchant

    sample_variance = prices.reduce(0) do |total,price_avg|
      total + ((price_avg - avg) ** 2)
    end/(prices.length - 1).to_f

    standard_deviation(sample_variance)
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

  def average_invoices_per_merchant
    (sales_engine.invoice_count.to_f/sales_engine.merchant_count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sample_variance = invoice_number_array.reduce(0) do |total,number|
      total + ((number - mean) ** 2)
    end/(invoice_number_array.length - 1).to_f

    standard_deviation(sample_variance)
  end

  def standard_deviation(sample_variance)
    Math.sqrt(sample_variance).round(2)
  end

  def invoice_number_array
    sales_engine.merchant_repository.map do |merchant|
      merchant.invoices.count
    end
  end

  def top_merchants_by_invoice_count
    doubled = average_invoices_per_merchant_standard_deviation * 2
    high_invoice_count = average_invoices_per_merchant + doubled
    sales_engine.merchant_repository.find_all do |merchant|
      merchant.invoices.count > high_invoice_count
    end
  end

  def bottom_merchants_by_invoice_count
    doubled = average_invoices_per_merchant_standard_deviation * 2
    low_invoice_count = average_invoices_per_merchant - doubled
    sales_engine.merchant_repository.find_all do |merchant|
      merchant.invoices.count < low_invoice_count
    end
  end

  def invoice_days_of_week_standard_deviation
    mean = sales_engine.invoice_days_of_week_mean
    incidences = sales_engine.invoice_days_of_week_incidences
    sample_variance = incidences.inject(0) do |total,incidence|
        total + ((incidence - mean) ** 2)
      end/(incidences.length - 1).to_f

      standard_deviation(sample_variance)
  end

  def top_days_by_invoice_count
    mean = sales_engine.invoice_days_of_week_mean
    high_day_invoice_count = invoice_days_of_week_standard_deviation  + mean
    hash = sales_engine.days_of_week_quantities
    return_hash = hash.select do |key, value|
     value > high_day_invoice_count
    end
    return_hash.keys
  end

  def invoice_status(status)
    x = sales_engine.invoice_status(status).to_f
    y = sales_engine.invoice_count.to_f
    ((x/y) * 100).round(2)
  end

  def total_revenue_by_date(date)
    sales_engine.total_revenue_by_date(date)
  end

  def revenue_by_merchant(merchant_id)
    sales_engine.revenue_by_merchant(merchant_id)
  end

  def merchants_with_pending_invoices
    sales_engine.merchants_with_pending_invoices
  end

  def merchants_with_only_one_item
    sales_engine.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    sales_engine.merchants_with_only_one_item_registered_in_month(month)
  end

  def merchants_ranked_by_revenue
    sales_engine.merchants_ranked_by_revenue
  end

  def top_revenue_earners(number = 20)
    sales_engine.top_revenue_earners(number)
  end

  def most_sold_item_for_merchant(merchant_id)
    sales_engine.most_sold_item_for_merchant(merchant_id)
  end

  def best_item_for_merchant(merchant_id)
    sales_engine.best_item_for_merchant(merchant_id)
  end
end
