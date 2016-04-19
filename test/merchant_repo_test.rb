require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require './lib/sales_engine'
require 'pry'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @mr = @se.merchant_repository
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




  #
  # def test_cannot_find_nil_name
  #   assert_equal nil, mr.find_by_name(nil)
  # end

  # def test_csv_loads_names
  #   assert_equal "510+ RealPush Icon Set", item_repo.load_csv()[0]
  #
  # end
  #
  # def test_csv_loads_descriptions
  #   assert_equal "You", item_repo.parse_data(item_repo.item_file)[1][0..2]
  # end
  #
  # def test_csv_loads_unit_price
  #   assert_equal "1200", item_repo.parse_data(item_repo.item_file)[2]
  # end
  #
  # def test_csv_loads_created_at
  #   assert_equal "2016-01-11 09:34:06 UTC",item_repo.parse_data(item_repo.item_file)[3]
  # end
  #
  # def test_csv_loads_updated_at
  #   assert_equal "2007-06-04 21:35:10 UTC",item_repo.parse_data(item_repo.item_file)[4]
  # end
  #
  # def test_all_items
  #   item_repo.parse_data(item_repo.item_file)
  #   assert_equal "510+ RealPush Icon Set",
  #    item_repo.all[0]
  # end
end
