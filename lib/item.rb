require 'pry'
class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id, :item_array

  def initialize(item_hash, item_array = nil)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @merchant_id = item_hash[:merchant_id]
    @item_array = item_array
  end

  def unit_price_to_dollars(unit_price)
    (unit_price.to_f)/100
  end

  def merchant
    item_array.find_merchant_by_merchant_id(self.merchant_id)
  end

end
