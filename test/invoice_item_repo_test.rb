require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'
require './lib/sales_engine'
require 'pry'

class InvoiceItemRepoTest < Minitest::Test
  attr_reader :ii, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })
    @ii = @se.invoice_items
  end

  def test_invoice_repo_class_exists
    assert_equal InvoiceItemRepo, ii.class
  end

  def test_can_find_all
    assert_equal 21830, ii.all.count
  end

  def test_can_count_all_invoice_items
    assert_equal 21830, ii.invoice_item_count
  end

  def test_can_find_by_id
    assert_equal 263519844, ii.find_by_id(1).item_id
  end

  def test_finds_nil_by_bad_id
    assert_nil ii.find_by_id(747565)
  end

  def test_find_all_by_item_id
    assert_equal 164, ii.find_all_by_item_id(263519844).count
  end

  def test_empty_array_for_bad_item_id
    assert_equal [], ii.find_all_by_item_id(1)
  end

  def test_find_all_by_invoice_id
    assert_equal 7, ii.find_all_by_invoice_id(6).count
  end

  def test_empty_array_for_bad_invoice_id
    assert_equal [], ii.find_all_by_invoice_id(1029381)
  end

  def test_all_invoice_items_quantity
    assert_equal 0, ii.all_invoice_items_quantity(1).count
  end
end
