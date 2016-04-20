require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test
attr_reader :i
  def setup
    @i = Invoice.new({
  :id          => 6,
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now,
  :updated_at  => Time.now,
  })
  end

  def test_invoice_exists
    assert Invoice, i.class
  end

  def test_id
    assert_equal 6, i.id
  end

  def test_customer_id
    assert_equal 7, i.customer_id
  end

  def test_merchant_id
    assert_equal 8, i.merchant_id
  end

  def test_status
    assert_equal "pending", i.status
  end

  def test_created_at
    assert Time.now, i.created_at
  end

  def test_updated_at
    assert Time.now, i.updated_at
  end
end
