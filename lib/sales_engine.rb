require 'csv'
require './lib/item_repo'

class SalesEngine
attr_accessor :all_files, :item_repository

  def initialize(items_file)
    # @item_repository = ItemRepo.new(self)
    require "pry"; binding.pry
  end

  def csv_files(items_file)
    require "pry"; binding.pry
    items.load_csv(items_file)
  end

  def self.from_csv(all_files)
    SalesEngine.new(all_files[:items])
                    # all_files[:merchants])
  end

end
