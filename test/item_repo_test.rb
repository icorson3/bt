require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/sales_engine'
require 'pry'

class ItemRepoTest < Minitest::Test
  attr_reader :ir
  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })
    @ir = @se.items
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

  def test_returns_nil_by_id
    assert_nil ir.find_by_id(7890)
  end
  #
  def test_finds_nil_by_name
    assert_nil ir.find_by_name("")
  end

  def test_can_find_by_name
    assert_equal 263395237, ir.find_by_name("510+ RealPush Icon Set").id
  end


  def test_find_all_with_description_returns_array
    assert_equal 263566670, ir.find_all_with_description("Stencil 18 inch cushion in Welsh &quot; happy wife happy life&quot;.  Feather inner included. Envelope closing on reverse")[0].id
  end

  def test_find_all_with_description_returns_items_with_price
    assert_equal 3, ir.find_all_by_price(2000).count
  end

  def test_find_all_with_range_returns_items_within_range
    assert_equal 2, ir.find_all_by_price_in_range(1000..1050).count
  end

  def test_finds_all_from_user_id
    assert_equal 1, ir.find_all_by_merchant_id(12335009).count
  end

  def test_item_count_can_count_items
    assert_equal 1367, ir.item_count
  end
  # def test_find_all_with_description_returns_empty_array
  #   assert_equal [],ir.find_all_with_description("")
  # end

end
