require 'csv'
require './lib/item_repo'
require './lib/merchant_repo'

class SalesEngine
attr_accessor :item_repository, :merchant_repository

  def initialize(items_file, merchant_file)
    @item_repository = ItemRepo.new(self)
    @merchant_repository = MerchantRepo.new(self)
    csv_files(items_file, merchant_file)

  end

  def csv_files(items_file, merchant_file)
    item_repository.load_csv(items_file)
    merchant_repository.load_csv(merchant_file)
  end

  def self.from_csv(all_files)
    SalesEngine.new(all_files[:items],
                    all_files[:merchants])
  end

#passing in hash to create an object with that hash. If wanted to do additional logic, create ItemRepo & MerchantRepo in from_csv
end

#users in database, want to fetch all, also want to be able to retrieve first name



# se = SalesEngine.from_csv('./data/items.csv')
# se = SalesEngine.new.from_csv('file')
