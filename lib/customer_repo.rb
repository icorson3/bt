require_relative 'customer'
require_relative 'sales_engine'
require 'csv'
require 'bigdecimal'

class CustomerRepo
  attr_accessor :customer_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @customer_array = []
  end

  def load_csv(customer_file)
    if customer_array.empty?
      contents = CSV.read customer_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:first_name]
      data << row[:last_name]
      data << Time.parse(row[:created_at])
      data << Time.parse(row[:updated_at])
      create_customer_object(data)
    end
  end

  def create_customer_object(data)
    @customer_array  <<  Customer.new({
      id: data[0],
      first_name: data[1],
      last_name: data[2],
      created_at: data[3],
      updated_at: data[4]
      }, self)
  end

  def all
    customer_array
  end

  def find_by_id(id)
    customer_array.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(substring_fragment)
    customer_array.find_all do |customer|
      all_lowercase = customer.first_name.downcase
      all_lowercase.include?(substring_fragment.downcase)
    end
  end

  def find_all_by_last_name(substring_fragment)
    customer_array.find_all do |customer|
      all_lowercase = customer.last_name.downcase
      all_lowercase.include?(substring_fragment.downcase)
    end
  end

end
