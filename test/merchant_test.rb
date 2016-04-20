require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
attr_reader :m
  def setup
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
end
