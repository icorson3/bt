require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
attr_reader :ii
  def setup
    @ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal.new(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def test_invoice_item_exists
    assert InvoiceItem, ii.class
  end

  def test_id
    assert_equal 6, ii.id
  end

  def test_item_id
    assert_equal 7, ii.item_id
  end

  def test_invoice_id
    assert_equal 8, ii.invoice_id
  end

  def test_quantity
    assert_equal 1, ii.quantity
  end

  def test_unit_price
    assert_equal BigDecimal.new(10.99, 4), ii.unit_price
  end

  def test_created_at
    assert Time.now, ii.created_at
  end

  def test_updated_at
    assert Time.now, ii.updated_at
  end
end
