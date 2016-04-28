require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items  => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       :invoices => "./data/invoices.csv",
       :invoice_items => "./data/invoice_items.csv",
       :transactions => './data/transactions.csv',
       :customers => './data/customers.csv'
      })
  end

  def test_loading_in_the_csv
    assert se.items
    assert se.merchants
    assert se.invoices
    assert se.merchants
    assert se.invoice_items
    assert se.transactions
    assert se.customers
  end

  def test_starting_relationship_layer
    merchant = se.merchants.find_by_id(12334105)
    merchant.items
    assert_equal 3, merchant.items.count
  end

  def test_item_merchant_relationship
    item = se.items.find_by_id(263395617)
    item.merchant
    assert_equal "Madewithgitterxx", item.merchant.name
  end

  def test_invoices_and_merchants_relationship
    merchant = se.merchants.find_by_id(12334105)
    merchant.invoices
    assert_equal 10, merchant.invoices.count
  end

  def test_invoice_and_items_relationship
    invoice = se.invoices.find_by_id(20)
    items = invoice.items
    assert_equal 5, items.count
  end

  def test_invoice_transactions_relationship
    invoice = se.invoices.find_by_id(20)
    transactions = invoice.transactions
    assert_equal 3, transactions.count
  end

  def test_customer_invoice_relationship
    invoice = se.invoices.find_by_id(20)
    customer = invoice.customer
    assert_equal "Sylvester", customer.first_name
  end

  def test_transactions_and_invoices_relationship
    transaction = se.transactions.find_by_id(40)
    invoice = transaction.invoice
    assert_equal 12335150, invoice.merchant_id
  end

  def test_merchants_and_customers_relationship
    merchant = se.merchants.find_by_id(12334194)
    customers = merchant.customers
    assert_equal 12, customers.count
  end

  def test_relationship_layer_between_customers_and_merchants
    customer = se.customers.find_by_id(30)
    merchants = customer.merchants
    assert_equal 5, merchants.count
  end

  def test_that_invoices_are_paid_in_full
    invoice = se.invoices.find_by_id(10)
    assert_equal true, invoice.is_paid_in_full?
  end

  def test_that_invoices_can_total
    invoice = se.invoices.find_by_id(1)
    assert_equal 21067.77, invoice.total
  end

end
