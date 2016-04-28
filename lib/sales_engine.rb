require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_item_repo'
require_relative 'invoice_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine
  attr_accessor :items, :merchants, :invoices,
                :invoice_items, :transactions, :customers

  def initialize(items_file, merchant_file,invoice_file,
                invoice_item_file, transaction_file, customer_file)
    @items = ItemRepo.new(self)
    @merchants = MerchantRepo.new(self)
    @invoices = InvoiceRepo.new(self)
    @invoice_items = InvoiceItemRepo.new(self)
    @transactions = TransactionRepo.new(self)
    @customers = CustomerRepo.new(self)
    csv_files(items_file, merchant_file, invoice_file,
              invoice_item_file, transaction_file, customer_file)
  end

  def csv_files(items_file, merchant_file, invoice_file,
                invoice_item_file, transaction_file, customer_file)
    items.load_csv(items_file)
    merchants.load_csv(merchant_file)
    invoices.load_csv(invoice_file)
    invoice_items.load_csv(invoice_item_file)
    transactions.load_csv(transaction_file)
    customers.load_csv(customer_file)
  end

  def self.from_csv(all_files)
    SalesEngine.new(all_files[:items],
    all_files[:merchants],
    all_files[:invoices],
    all_files[:invoice_items],
    all_files[:transactions],
    all_files[:customers])
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      items.find_by_id(invoice_item.item_id)
    end
  end

  def find_invoice_items_by_item_id(id)

    items.find_by_id(id).map do |item|
      invoice_items.find_all_by_item_id(item.id)
    end
  end

  def find_item_by_item_id(id)
    items.find_by_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_invoice_by_transaction_id(id)
    transaction_invoice_id = transactions.find_by_id(id).invoice_id
    invoices.find_by_id(transaction_invoice_id)
  end

  def find_customers_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id).map do |merchant_customer|
      customers.find_by_id(merchant_customer.customer_id)
    end.uniq
  end

  def find_merchants_by_customer_id(id)
    invoices.find_all_by_customer_id(id).map do |customer_merchant|
      merchants.find_by_id(customer_merchant.merchant_id)
    end.uniq
  end

  def find_invoice_items_by_invoice_id(id)
    invoice = invoices.find_by_id(id)
    invoice_items.find_all_by_invoice_id(invoice.id)
  end

  def find_paid_by_status(id)
    transactions.find_all_by_invoice_id(id).any? do |transaction|
      transaction.result == "success"
    end
  end

  def item_count
    items.item_count
  end

  def merchant_count
    merchants.merchant_count
  end

  def invoice_count
    invoices.invoice_count
  end

  def merchant_repository
    merchants.merchant_array
  end

  def item_repository
    items.item_array
  end

  def invoice_repository
    invoices.invoice_array
  end

  def invoice_item_repository
    invoice_items.invoice_item_array
  end

  def invoice_days_of_week_mean
    invoices.days_of_week_mean
  end

  def days_of_week_quantities
    invoices.days_of_week_quantities
  end

  def invoice_days_of_week_incidences
    invoices.days_of_week_incidences
  end

  def invoice_status(status)
    invoices.find_all_by_status(status).count
  end

  def find_total(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice_items|
      invoice_items.quantity * invoice_items.unit_price
    end.reduce(:+)
  end

  def most_sold_item_for_merchant(merchant_id)
    merchants.find_by_id(merchant_id).most_sold_item_for_merchant
  end

  def best_item_for_merchant(merchant_id)
    merchants.find_by_id(merchant_id).best_item_for_merchant
  end

  def total_revenue_by_date(date)
    created_date = invoices.find_all_by_created_at(date)
    created_date.map do |invoice|
      find_total(invoice.id)
    end.reduce(:+)
  end

  def revenue_by_merchant(merchant_id)
    merchant = merchants.find_by_id(merchant_id)
    merchant.paid_in_full_invoices.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def top_revenue_earners(number)
    adjusted_number = number-1
    merchants_ranked_by_revenue[0..adjusted_number]
  end

  def merchants_ranked_by_revenue
    sorted = merchant_repository_ids.sort_by do |merchant_id|
      revenue_by_merchant(merchant_id).to_f
    end.reverse
    sorted.map {|id| merchants.find_by_id(id)}
  end

  def merchants_with_pending_invoices
    merchants.merchants_with_pending_invoices
  end

  def merchants_with_only_one_item
    merchants.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants.merchants_with_only_one_item_registered_in_month(month)
  end

  def merchant_repository_ids
    merchant_repository.map do |merchant|
      merchant.id
    end
  end

  def successful_invoices(merchant_id)
    find_invoices_by_merchant_id(merchant_id).select do |invoice|
     invoice.is_paid_in_full?
   end
  end

  def merchant_invoice_items(merchant_id)
    successful_invoices(merchant_id).map do |merchant_invoice|
      invoice_items.find_all_by_invoice_id(merchant_invoice.id)
    end.flatten
  end

  def best_invoice_revenue(merchant_id)
    merchant_invoice_items(merchant_id).max_by do |invoice_item|
    invoice_item.revenue
    end.revenue
  end

  def top_invoice_items(merchant_id)
    merchant_invoice_items(merchant_id).select do |invoice_item|
    invoice_item.revenue == best_invoice_revenue(merchant_id)
    end[0]
  end

  def best_item_for_merchant(merchant_id)
     items.find_by_id(top_invoice_items(merchant_id).item_id)
  end
end
