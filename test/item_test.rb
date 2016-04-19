require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test
attr_reader :i
  def setup
    @i = Item.new({
  :name        => "Pencil",
  :description => "You can use it to write things",
  :unit_price  => BigDecimal.new(10.99,4),
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })
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
end
