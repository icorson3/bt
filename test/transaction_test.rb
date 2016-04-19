require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/transaction'

class TransactionTest < Minitest::Test
attr_reader :t
  def setup
    @t = Transaction.new({
  :id => 6,
  :invoice_id => 8,
  :credit_card_number => "4242424242424242",
  :credit_card_expiration_date => "0220",
  :result => "success",
  :created_at => Time.now,
  :updated_at => Time.now
  })
  end

  def test_transaction_exists
    assert Transaction, t.class
  end

  def test_id
    assert_equal 6, t.id
  end

  def test_invoice_id
    assert_equal 8, t.invoice_id
  end

  def test_credit_card_number
    assert_equal "4242424242424242", t.credit_card_number
  end

  def test_credit_card_expiration
    assert_equal "0220", t.credit_card_expiration_date
  end

  def test_result
    assert_equal "success", t.result
  end
  def test_created_at
    assert Time.now, t.created_at
  end

  def test_updated_at
    assert Time.now, t.updated_at
  end
end
