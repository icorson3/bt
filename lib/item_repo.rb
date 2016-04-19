require './lib/item'
require 'csv'
# require './lib/sales_engine'

class ItemRepo
attr_accessor :item_file, :item_array, :data
  def initialize(sales_engine)
    # (sales_engine)
    @sales_engine = sales_engine
    @item_array = []
    # @data = []# @item = Item.new    # sales_engine.item_repository
  end

  # def load_csv(item_file)
  #   require "pry"; binding.pry
  #   if items_file.empty?
  #     contents = CSV.read(items_file)
  #     # headers: true, header_converters: :symbol
  #     parse_data(contents)
  # end
  # end
  def load_csv(item_file)
    if item_array.empty?
      contents = CSV.read './data/items.csv', headers: true, header_converters: :symbol
    end
    parse_data(contents)
  end

  def create_item_object(data)
    @item_array  <<  Item.new({
          name: data[0],
          description: data[1],
          unit_price:  data[2],
          created_at: data[3],
          updated_at: data[4]
      }, self)
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:name]
      data << row[:description]
      data << row[:unit_price]
      data << row[:created_at]
      data << row[:updated_at]
      create_item_object(data)
    end
  end

  def all
   item_array
  end
end
