require 'minitest/autorun'
require 'minitest/pride'
require './lib/transaction_repo'
require './lib/sales_engine'
require 'pry'

class TranscationRepoTest < Minitest::Test
  attr_reader :tr, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv',
      :customers => './data/customers.csv'
      })
    @tr = @se.transactions
  end

  def test_invoice_repo_class_exists
    assert_equal TransactionRepo, tr.class
  end

  def test_can_find_all
    assert_equal 4985, tr.all.count
  end

  def test_can_count_all_transactions
    assert_equal 4985, tr.transaction_count
  end

  def test_can_find_by_id
    assert_equal 3715, tr.find_by_id(5).invoice_id
  end

  def test_finds_nil_with_bad_id
    assert_nil tr.find_by_id(8347)
  end

  def test_can_find_all_by_invoice_id
    assert_equal 2, tr.find_all_by_invoice_id(750).count
  end

  def test_finds_empty_array_for_bad_invoice_id
    assert_equal [], tr.find_all_by_invoice_id(384757575)
  end

  def test_can_find_all_by_credit_card_number
    assert_equal 1, tr.find_all_by_credit_card_number(4113758460176252).count
  end

  def test_finds_empty_array_for_bad_credit_card_number
    assert_equal [], tr.find_all_by_credit_card_number(384757575)
  end

  def test_find_all_by_result
    assert_equal 4158, tr.find_all_by_result("success").count
  end

  def test_finds_empty_array_for_bad_invoice_id
    assert_equal [], tr.find_all_by_result("")
  end


end
