require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
attr_reader :se, :sa
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
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

end
