require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test
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

  def test_can_find_items_by_invoice_id
    invoice = se.invoices.find_by_id(20)
    assert_equal 5, invoice.items.count
  end

  def test_can_find_transactions_by_invoice_id
    invoice = se.invoices.find_by_id(20)
    assert_equal 3, invoice.transactions.count
  end

  def test_can_find_customers_by_invoice_id
    invoice = se.invoices.find_by_id(20)
    assert_equal "Sylvester", invoice.customer.first_name
  end

  def test_invoice_is_paid_in_full
    invoice = se.invoices.find_by_id(272)
    assert_equal true, invoice.is_paid_in_full?
  end

  def test_invoice_totals
    invoice = se.invoices.find_by_id(272)
    assert_equal BigDecimal, invoice.total.class
  end
end
