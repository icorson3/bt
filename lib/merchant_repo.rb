require_relative 'merchant'
require 'csv'
require_relative 'sales_engine'

class MerchantRepo
  attr_accessor :merchant_array, :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant_array = []
  end

  def load_csv(merchant_file)
    if merchant_array.empty?
      contents = CSV.read merchant_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:name]
      create_merchant_object(data)
    end
  end

  def create_merchant_object(data)
    @merchant_array << Merchant.new({
      id: data[0],
      name: data[1]
      }, self)
    end

  def all
    merchant_array
  end

  def find_by_id(id)
    merchant_array.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchant_array.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchant_array.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

end
