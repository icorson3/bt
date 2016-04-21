require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/sales_engine'
require 'pry'

class InvoiceRepoTest < Minitest::Test
  attr_reader :i, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
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

  def test_finds_all_merchant_id
    assert_equal 16, i.find_all_by_merchant_id(12335938).count
  end

  def test_finds_all_by_status
    assert_equal 1473, i.find_all_by_status("pending").count
  end

  def test_can_count_all_invoices
    assert_equal 4985, i.invoice_count
  end
end
