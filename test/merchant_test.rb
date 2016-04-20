require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
attr_reader :m, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @m = Merchant.new({:id => 5, :name => "Turing School"})
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


end
