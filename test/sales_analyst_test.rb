require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
attr_reader :se, :sa
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })
    @sa = SalesAnalyst.new(se)
  end

  def test_provides_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_returns_merchants_with_highest_item_counts
    assert_equal "Keckenbauer", sa.merchants_with_high_item_count[0].name
  end

  def test_average_item_price_per_merchant
    assert_equal BigDecimal, sa.average_item_price_for_merchant(12334105).class
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal, sa.average_average_price_per_merchant.class
  end

  def test_standard_deviation_works_for_items_per_merchant
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_standard_deviation_works_for_item_price
    assert_equal 2902.69, sa.average_item_price_standard_deviation
  end

  def test_highest_priced_items_returned_from_golden_items
    assert_equal 5, sa.golden_items.count
  end

  def test_average_invoices_per_merchant_works
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_days_of_week_standard_deviation
    assert_equal 18.07, sa.invoice_days_of_week_standard_deviation
  end

  def test_top_days_by_invoice_count
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date
    date = Time.parse("2003-11-07")
    se.invoices.find_all_by_created_at(date)
    assert_equal BigDecimal, sa.total_revenue_by_date(date).class
  end

  def test_merchants_with_pending_invoices
    assert_equal 0, sa.merchants_with_pending_invoices
  end

  def test_revenue_by_merchant
    assert_equal BigDecimal, sa.revenue_by_merchant(12334105).class
  end

  def test_merchants_ranked_by_revenue
    assert_equal 475,sa.merchants_ranked_by_revenue.class
  end

  def test_most_sold_item_for_merchant
    assert_equal 5, sa.most_sold_item_for_merchant(12334105).class
  end

  def test_best_item_for_merchant
    assert_equal 263561102, sa.best_item_for_merchant(12334105).class
  end
end
