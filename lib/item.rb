class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item_hash, item_array = nil)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @merchant_id = item_hash[:merchant_id]
    # @item_array = item_array
  end


end