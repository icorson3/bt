require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
attr_reader :m, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })

    @m = Merchant.new({
      :id => 5, :name => "Turing School"})
  end

  def test_merchant_class_exists
    assert Merchant, m.class
  end

  def test_merchant_id_works
    assert_equal 5, m.id
  end

  def test_merchant_name_works
    assert_equal "Turing School", m.name
  end

  def test_items_are_in_merchant_repo
    merchant = se.merchants.find_by_id(12334105)
    assert_equal "Vogue Paris Original Givenchy 2307", merchant.items[0].name
  end

  def test_invoices_for_merchants
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 10, merchant.invoices.count
  end

  def test_valid_invoices_only
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 5, merchant.valid_invoices.count
  end

  def test_can_find_customers_for_merchants
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 10, merchant.customers.count
  end

  def test_can_find_invoice_items
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 45, merchant.invoice_items.count
  end

  def test_invoice_item_max
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 10, merchant.invoice_item_max
  end

  def test_most_sold_item_for_merchant
    merchant = se.merchants.find_by_id(12337105)
    assert_equal 4, merchant.most_sold_item_for_merchant.count
  end
end
