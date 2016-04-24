require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'
require 'time'
require 'bigdecimal'

class InvoiceRepo
  attr_accessor :invoice_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
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
      data << row[:status].to_sym
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
      }, self)
  end

  def all
    invoice_array
  end

  def find_by_id(id)
    invoice_array.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    invoice_array.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    invoice_array.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    invoice_array.find_all { |invoice| invoice.status == status }
  end

  def find_merchant_by_merchant_id(merchant_id)
    sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def find_items_by_invoice_id(id)
    sales_engine.find_items_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    sales_engine.find_customer_by_customer_id(customer_id)
  end

  def find_paid_by_status(id)
    sales_engine.find_paid_by_status(id)
  end

  def find_total(id)
    sales_engine.find_total(id)
  end

  def invoice_count
    all.count
  end

  def days_of_week
    invoice_array.map { |invoice| invoice.created_at.strftime('%A') }
  end

  def days_of_week_grouped
    days_of_week.group_by { |day| day }
  end

  def days_of_week_quantities
    result_hash = {}
    days_of_week_grouped.each { |key,value| result_hash[key] = value.count }
    result_hash
  end

  def days_of_week_incidences
    days_of_week_quantities.values
  end

  def days_of_week_mean
    invoice_days = days_of_week_quantities.values
    total_sum = invoice_days.inject(0) { |total,incidences| total + incidences }
    total_sum / 7
  end

  #put in the invoice id and get the invoice. find invoice_items by invoice_id and then get items


end
