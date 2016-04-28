require_relative 'transaction'
require_relative 'sales_engine'
require 'csv'
require 'time'
# require 'bigdecimal'

class TransactionRepo
  attr_accessor :transaction_array, :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @transaction_array = []
  end

  def load_csv(transaction_file)
    if transaction_array.empty?
      contents = CSV.read transaction_file,
      headers: true, header_converters: :symbol
      parse_data(contents)
    end
  end

  def parse_data(contents)
    contents.each do |row|
      data = []
      data << row[:id].to_i
      data << row[:invoice_id].to_i
      data << row[:credit_card_number].to_i
      data << row[:credit_card_expiration_date]
      data << row[:result]
      data << Time.parse(row[:created_at])
      data << Time.parse(row[:updated_at])
      create_transcation_object(data)
    end
  end

  def create_transcation_object(data)
    @transaction_array  <<  Transaction.new({
      id: data[0],
      invoice_id: data[1],
      credit_card_number:  data[2],
      credit_card_expiration_date: data[3],
      result: data[4],
      created_at: data[5],
      updated_at: data[6]
      }, self)
  end

  def all
    transaction_array
  end

  def transaction_count
    transaction_array.count
  end

  def find_by_id(id)
    transaction_array.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transaction_array.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transaction_array.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transaction_array.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_transaction_id(id)
    sales_engine.find_invoice_by_transaction_id(id)
  end


end
