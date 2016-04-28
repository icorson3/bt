require_relative 'sales_engine'
require_relative 'item'
require 'bigdecimal'
require 'time'
require 'csv'

class ItemRepo
  attr_accessor :item_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_array = []
  end

  def item_count
    all.count
  end

  def load_csv(item_file)
    if item_array.empty?
      contents ||= CSV.read item_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:name]
      data << row[:description]
      data << BigDecimal.new(row[:unit_price].to_i)/BigDecimal.new(100)
      data << Time.parse(row[:created_at])
      data << Time.parse(row[:updated_at])
      data << row[:merchant_id].to_i
      create_item_object(data)
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

  def all
    item_array
  end

  def find_by_id(id)
    item_array.find { |item| item.id == id }
  end

  def find_by_name(name)
    item_array.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(phrase)
    item_array.find_all { |item| item.description.downcase == phrase.downcase }
  end

  def find_all_by_price(unit_price)
    item_array.find_all { |item| item.unit_price == unit_price }
  end

  def find_all_by_price_in_range(range)
    item_array.find_all { |item| item.unit_price.between?(range.min,range.max) }
  end

  def find_merchant_by_merchant_id(merchant_id)
      sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def find_all_by_merchant_id(merchant_id)
      item_array.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_invoice_items_by_item_id(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end
end
