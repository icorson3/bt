class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item_hash, item_array = nil)
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    # @item_array = item_array
  end

  
end
