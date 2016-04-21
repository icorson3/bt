require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'
require 'csv'


class SalesEngine
attr_accessor :items, :merchants

  def initialize(items_file, merchant_file)
    @items = ItemRepo.new(self)
    @merchants = MerchantRepo.new(self)
    csv_files(items_file, merchant_file)

  end
#add method to items
  def csv_files(items_file, merchant_file)
    items.load_csv(items_file)
    merchants.load_csv(merchant_file)
  end

  def self.from_csv(all_files)
    SalesEngine.new(all_files[:items],
                    all_files[:merchants])
  end

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end
#passing in hash to create an object with that hash. If wanted to do additional logic, create ItemRepo & MerchantRepo in from_csv
end

#users in database, want to fetch all, also want to be able to retrieve first name



# se = SalesEngine.from_csv('./data/items.csv')
# se = SalesEngine.new.from_csv('file')
