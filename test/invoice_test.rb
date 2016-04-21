require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
attr_reader :i, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })

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

  def test_finds_merchant_by_merchant_id
    invoice = se.invoices.find_by_id(9)

    assert_equal "JewelleAccessories", invoice.merchant.name
  end

end
