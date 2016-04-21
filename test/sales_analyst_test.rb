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
      :invoices => "./data/invoices.csv"

      })
    @sa = SalesAnalyst.new(se)
  end

  def test_provides_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_item_price_per_merchant
    assert_equal BigDecimal, sa.average_item_price_for_merchant(12334105).class
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal, sa.average_average_price_for_merchant
  end
end
