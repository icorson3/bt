class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_array

  def initialize(invoice_hash, invoice_array = nil)
    @id = invoice_hash[:id]
    @customer_id = invoice_hash[:customer_id]
    @merchant_id = invoice_hash[:merchant_id]
    @status = invoice_hash[:status]
    @created_at = invoice_hash[:created_at]
    @updated_at = invoice_hash[:updated_at]
    @invoice_array = invoice_array
  end

  def merchant
    invoice_array.find_merchant_by_merchant_id(self.merchant_id)
  end

end
