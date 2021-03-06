require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/sales_engine'
require 'pry'

class InvoiceRepoTest < Minitest::Test
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
    @i = @se.invoices
  end

  def test_invoice_repo_class_exists
    assert_equal InvoiceRepo, i.class
  end

  def test_can_find_all
    assert_equal 1, i.all[0].id
  end

  def test_can_find_by_id
    assert_equal 12335938, i.find_by_id(1).merchant_id
  end

  def test_finds_nil_by_bad_id
    assert_nil i.find_by_id("")
  end

  def test_finds_customer_id
    assert_equal 8, i.find_all_by_customer_id(1).count
  end

  def test_finds_empty_array_by_bad_customer_id
    assert_equal [], i.find_all_by_customer_id(38387)
  end

  def test_finds_all_merchant_id
    assert_equal 16, i.find_all_by_merchant_id(12335938).count
  end

  def test_finds_empty_array_by_bad_merchant_id
    assert_equal [], i.find_all_by_merchant_id(1)
  end

  def test_finds_all_by_status
    assert_equal 1473, i.find_all_by_status(:pending).count
  end

  def test_finds_empty_array_by_bad_status
    assert_equal [], i.find_all_by_status(:iteration)
  end

  def test_can_count_all_invoices
    assert_equal 4985, i.invoice_count
  end

  def test_days_of_week_finds_number_of_each_days_invoices
    assert_equal ({"Saturday"=>729, "Friday"=>701, "Wednesday"=>741, "Monday"=>696, "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}), i.days_of_week_quantities
  end

  def test_days_of_week_mean
    assert_equal 712, i.days_of_week_mean
  end

  def test_can_find_by_created_at_date
    date = Time.parse("2009-02-07")
    assert_equal 1, i.find_all_by_created_at(date).count
  end
end
