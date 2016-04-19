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
