require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require './lib/sales_engine'
require 'pry'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })
    @mr = @se.merchants
  end

  def test_item_repo_class_exists
    assert_equal MerchantRepo, mr.class
  end

  def test_can_find_all
    assert_equal "Shopin1901", mr.all[0].name
  end

  def test_can_find_by_id
    assert_equal "Shopin1901", mr.find_by_id(12334105).name
  end

  def test_returns_nil_by_id
    assert_nil mr.find_by_id(7890)
  end

  def test_finds_nil_by_name
    assert_nil mr.find_by_name("")
  end

  def test_can_find_by_name
    assert_equal 12334105, mr.find_by_name("Shopin1901").id
  end
  #
  def test_finds_all_by_name
    assert_equal 7, mr.find_all_by_name("love").count
  end

  def test_can_count_merchants
    assert_equal 475, mr.merchant_count
  end

end
