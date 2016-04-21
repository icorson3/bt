require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'
# require 'time'
# require 'bigdecimal'

class InvoiceRepo
  attr_accessor :invoice_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine ||= sales_engine
    @invoice_array = []
  end

  def load_csv(invoice_file)
    if invoice_array.empty?
      contents = CSV.read invoice_file, headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:customer_id].to_i
      data << row[:merchant_id].to_i
      data << row[:status]
      data << Time.parse(row[:created_at])
      data << Time.parse(row[:updated_at])
      create_item_object(data)
    end
  end

  def create_item_object(data)
    @invoice_array  <<  Invoice.new({
      id: data[0],
      customer_id: data[1],
      merchant_id: data[2],
      status:  data[3],
      created_at: data[4],
      updated_at: data[5]
      }, invoice_array)
  end

  def all
    invoice_array
  end

  def find_by_id(id)
    invoice_array.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoice_array.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoice_array.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoice_array.find_all do |invoice|
      invoice.status == status
    end
  end

end
