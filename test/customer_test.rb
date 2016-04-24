require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
require './lib/sales_engine'

class CustomerTest < Minitest::Test
attr_reader :c, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })

    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def test_customer_exists
    assert Customer, c.class
  end

  def test_id
    assert_equal 6, c.id
  end

  def test_first_name
    assert_equal "Joan", c.first_name
  end

  def test_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_created_at
    assert Time.now, c.created_at
  end

  def test_updated_at
    assert Time.now, c.updated_at
  end

  def test_can_find_merchants_by_customer_id
    customer = se.customers.find_by_id(30)
    assert_equal 5, customer.merchants.count
  end
end
