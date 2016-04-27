require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require './lib/sales_engine'
class ItemTest < Minitest::Test
attr_reader :i, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })

    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }, self)
  end

  def test_item_class_exists
    assert Item, i.class
  end

  def test_name_returns_name_values
    assert_equal "Pencil", i.name
  end

  def test_description_returns_string_with_description
    assert_equal "You can use it to write things", i.description
  end

  def test_unit_price_provides_price_of_item
    assert_equal BigDecimal.new(10.99,4), i.unit_price
  end

  def test_unit_price_class_big_decimal
    assert_kind_of BigDecimal, i.unit_price
  end

  def test_created_at_returns_created_time
    assert Time.now, i.created_at
  end

  def test_updated_at_returns_updated_time
    assert Time.now, i.updated_at
  end

  def test_unit_price_converts_to_dollars
    assert_equal 12.00, i.unit_price_to_dollars(1200)
  end

  def test_merchant_returns_correct_merchant
    sample_item = se.items.find_by_id(263395721)
    assert_equal "Madewithgitterxx", sample_item.merchant.name
  end

  # def test_quantity_sold_returns_total_quantity_sold_for_item
  #   sample_item = se.items.find_by_id(263395721)
  #   assert_equal 0,sample_item.quantity_sold
  # end

end
