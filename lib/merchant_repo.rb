require_relative 'sales_engine'
require_relative 'merchant'
require 'csv'

class MerchantRepo
  attr_accessor :merchant_array, :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant_array = []
  end

  def load_csv(merchant_file)
    if merchant_array.empty?
      contents ||= CSV.read merchant_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:name]
      data << Time.parse(row[:created_at])
      create_merchant_object(data)
    end
  end

  def create_merchant_object(data)
    @merchant_array << Merchant.new({
      id: data[0],
      name: data[1],
      created_at: data[2]
      }, self)
    end

  def all
    merchant_array
  end

  def merchant_count
    all.count
  end

  def find_items_by_merchant_id(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def find_customers_by_merchant_id(id)
    sales_engine.find_customers_by_merchant_id(id)
  end

  def find_by_id(id)
    merchant_array.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    merchant_array.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    merchant_array.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def find_total_revenue(id)
    find_invoices_by_merchant_id(id)
  end

  def all_invoices
    merchant_array.map do |merchant|
      find_invoices_by_merchant_id(merchant.id)
    end
  end

  def merchants_with_pending_invoices
    merchant_array.find_all do |merchant|
      merchant.has_pending_invoices?
    end
  end

  def merchants_with_only_one_item
    merchant_array.find_all do |merchant|
      merchant.has_one_item?
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchant_array.select do |merchant|
      merchant.creation_date_items(month) == 1
    end
  end

end
