require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'
require_relative 'invoice_repo'
require 'csv'

class SalesEngine
attr_accessor :items, :merchants, :invoices

  def initialize(items_file, merchant_file,invoice_file)
    @items = ItemRepo.new(self)
    @merchants = MerchantRepo.new(self)
    @invoices = InvoiceRepo.new(self)
    csv_files(items_file, merchant_file, invoice_file)

  end
#add method to items
  def csv_files(items_file, merchant_file, invoice_file)
    items.load_csv(items_file)
    merchants.load_csv(merchant_file)
    invoices.load_csv(invoice_file)

  end

  def self.from_csv(all_files)
    SalesEngine.new(all_files[:items],
                    all_files[:merchants],
                    all_files[:invoices])
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
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

#passing in hash to create an object with that hash. If wanted to do additional logic, create ItemRepo & MerchantRepo in from_csv
end

#users in database, want to fetch all, also want to be able to retrieve first name



# se = SalesEngine.from_csv('./data/items.csv')
# se = SalesEngine.new.from_csv('file')
