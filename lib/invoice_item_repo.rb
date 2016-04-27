require_relative 'invoice_item'
require_relative 'sales_engine'
require 'csv'
require 'bigdecimal'
require 'time'

class InvoiceItemRepo
  attr_accessor :invoice_item_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @invoice_item_array = []
  end

  def load_csv(invoice_item_file)
    if invoice_item_array.empty?
      contents = CSV.read invoice_item_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:item_id].to_i
      data << row[:invoice_id].to_i
      data << row[:quantity].to_i
      data << BigDecimal.new(row[:unit_price])/100
      data << Time.parse(row[:created_at])
      data << Time.parse(row[:updated_at])
      create_invoice_item_object(data)
    end
  end

  def create_invoice_item_object(data)
    @invoice_item_array  <<  InvoiceItem.new({
      id: data[0],
      item_id: data[1],
      invoice_id: data[2],
      quantity:  data[3],
      unit_price: data[4],
      created_at: data[5],
      updated_at: data[6]
      }, self)
  end

  def all
    invoice_item_array
  end

  def invoice_item_count
    invoice_item_array.count
  end

  def find_by_id(id)
    invoice_item_array.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_item_array.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_item_array.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def find_all_by_date(date)
    invoice_item_array.find_all { |invoice_item| invoice_item.created_at.strftime("%Y-%d-%m") == date }
  end
end
