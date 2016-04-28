class Merchant
attr_reader :id, :name, :created_at, :merchant_array
  def initialize(merchant_hash, merchant_array = nil)
    @id = merchant_hash[:id]
    @name = merchant_hash[:name]
    @created_at = merchant_hash[:created_at]
    @merchant_array = merchant_array
  end

  def items
    merchant_array.find_items_by_merchant_id(self.id)
  end

  def invoices
    merchant_array.find_invoices_by_merchant_id(self.id)
  end

  def valid_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def valid_invoice_ids
    valid_invoices.map do |invoice|
      invoice.id
    end
  end

  def invoice_items
    valid_invoices.map do |invoice|
      invoice.invoice_items
    end
  end

  def invoice_item_max
    invoice_items.max_by do |invoice_item|
    invoice_item.quantity
    end.quantity
  end

  def invoice_items_with_max
    invoice_items.find_all do |invoice_item|
      id = invoice_item.invoice_id
      x = valid_invoice_ids.include?(id)
      invoice_item.quantity == invoice_item_max && x
    end
  end

  def most_sold_item_for_merchant
    invoice_items_with_max.map do |invoice_item|
    merchant_array.find_item_by_item_id(invoice_item.item_id)
    end.flatten
  end

  def customers
    merchant_array.find_customers_by_merchant_id(self.id)
  end

  def has_pending_invoices?
    !(invoices.find_all do |invoice|
      !invoice.is_paid_in_full?
    end.empty?)
  end

  def creation_date_items(month)
    if created_at.strftime("%B") == month
      items.count
    end
  end

  def has_one_item?
     items.count == 1
   end

  def paid_in_full_invoices
    invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
  end

    def invoice_items
      invoices.map do |invoice|
        invoice.invoice_items
      end.flatten
    end

end
