require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv"
      # :merchants => "./data/merchants.csv"
      })
  end

  def test_sales_engine_class_exists

  end

  def test_sales_engine_csv_files_exist

    assert_equal ({:items=>"./data/items.csv", :merchants=>"./data/merchants.csv"}), se.csv_files(se)
  end

  # def test_can_take_in_the_csvs
  #   assert true, se.from_csv({})
  # end

end