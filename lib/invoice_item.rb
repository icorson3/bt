class InvoiceItem
attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
  def initialize(invoice_item_hash)
    @id = invoice_item_hash[:id]
    @item_id = invoice_item_hash[:item_id]
    @invoice_id = invoice_item_hash[:invoice_id]
    @quantity = invoice_item_hash[:quantity]
    @unit_price = invoice_item_hash[:unit_price]
    @created_at = invoice_item_hash[:created_at]
    @updated_at = invoice_item_hash[:updated_at]
  end
end
