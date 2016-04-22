require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repo'
require './lib/sales_engine'
require 'pry'

class CustomerRepoTest < Minitest::Test
  attr_reader :c, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })
    @c = @se.customers
  end

  def test_invoice_repo_class_exists
    assert_equal CustomerRepo, c.class
  end

  def test_can_find_all
    assert_equal 1, c.all[0].id
  end

  def test_can_find_by_id
    assert_equal "Mariah", c.find_by_id(3).first_name
  end

  def test_finds_nil_by_bad_id
    assert_nil c.find_by_id("")
  end

  def test_can_find_all_by_first_name_fragment
    assert_equal 5, c.find_all_by_first_name("joe").count
  end

  def test_can_find_empty_array_without_matching_first_name
    assert_equal [], c.find_all_by_first_name("zij")
  end

  def test_can_find_all_by_last_name_fragment
    assert_equal 39, c.find_all_by_last_name("li").count
  end

  def test_can_find_empty_array_without_matching_last_name
    assert_equal [], c.find_all_by_last_name("zij")
  end
#
#   def test_finds_customer_id
#     assert_equal 8, i.find_all_by_customer_id(1).count
#   end
#
#   def test_finds_all_merchant_id
#     assert_equal 16, i.find_all_by_merchant_id(12335938).count
#   end
#
#   def test_finds_all_by_status
#     assert_equal 1473, i.find_all_by_status(:pending).count
#   end
#
#   def test_can_count_all_invoices
#     assert_equal 4985, i.invoice_count
#   end
#
#   def test_days_of_week_finds_number_of_each_days_invoices
#     assert_equal ({"Saturday"=>729, "Friday"=>701, "Wednesday"=>741, "Monday"=>696, "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}), i.days_of_week_quantities
#   end
#
#   def test_days_of_week_mean
#     assert_equal 712, i.days_of_week_mean
#   end
end
