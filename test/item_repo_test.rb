require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/sales_engine'
require 'pry'

class ItemRepoTest < Minitest::Test
  attr_reader :ir
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv"
      # :merchants => "./data/merchants.csv"
      })
    @ir = @se.item_repository
  end

  def test_item_repo_class_exists
    assert_equal ItemRepo, ir.class
  end

  def test_case_name
    assert_equal "510+ RealPush Icon Set", ir.all[0].name
  end

  def test_can_find_by_id
    assert_equal "510+ RealPush Icon Set", ir.find_by_id(263395237).name
  end

  # def test_returns_nil_by_id
  #   assert_equal nil, ir.find_by_id(nil)
  # end
  #
  # def test_finds_nil_by_name
  #   assert_equal nil, ir.find_by_name(nil)
  # end

  def test_can_find_by_name
    assert_equal 263395237, ir.find_by_name("510+ RealPush Icon Set").id
  end


  def test_find_all_with_description_returns_array
    assert_equal 263453001,ir.find_all_with_description("Coffee Mug Holder, Wall Decor")[0].id
  end

  def test_find_all_with_description_returns_items_with_price
    assert_equal 48, ir.find_all_by_price(2000).count
  end

  def test_find_all_with_range_returns_items_within_range
    assert_equal 64, ir.find_all_by_price_in_range(1000..1050).count
  end

  def test_finds_all_from_user_id
    assert_equal 1, ir.find_all_by_merchant_id(12335009).count
  end

  # def test_find_all_with_description_returns_empty_array
  #   assert_equal [],ir.find_all_with_description(nil)
  # end


  #
  # def test_cannot_find_nil_name
  #   assert_equal nil, ir.find_by_name(nil)
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
