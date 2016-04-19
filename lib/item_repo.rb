require './lib/item'
require 'csv'
require './lib/sales_engine'

class ItemRepo
  attr_accessor :item_array, :data
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
      contents = CSV.read item_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def create_item_object(data)
    @item_array  <<  Item.new({
      id: data[0],
      name: data[1],
      description: data[2],
      unit_price:  data[3],
      created_at: data[4],
      updated_at: data[5],
      merchant_id: data[6]
      }, self)
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id]
      data << row[:name]
      data << row[:description]
      data << row[:unit_price].to_i
      data << row[:created_at]
      data << row[:updated_at]
      data << row[:merchant_id]
      create_item_object(data)
    end
  end

  def all
    item_array
  end
  #
  def find_by_id(id)
    if item_array.empty?
      nil
    else item_array.find do |item|
      item.id == id
      end
    end
  end

  def find_by_name(name)
    if item_array.empty?
      return nil
    else item_array.find do |item|
      item.name.downcase == name.downcase
      end
    end
  end

  def find_all_with_description(description)
    if item_array.empty?
      item_array
    else
      item_array.find_all do |item|
        item.description.downcase == description.downcase
      end
    end
  end

  def find_all_by_price(unit_price)
    if item_array.empty?
      item_array
    else
      item_array.find_all do |item|
        item.unit_price == unit_price
      end
    end
  end

  def find_all_by_price_in_range(range)
    if item_array.empty?
      item_array
    else
      item_array.find_all do |item|
        item.unit_price.between?(range.min,range.max)
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    if item_array.empty?
      item_array
    else
      item_array.find_all do |item|
        item.merchant_id == merchant_id
      end
    end
  end
end
