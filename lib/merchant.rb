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

  def customers
    merchant_array.find_customers_by_merchant_id(self.id)
  end

  def has_pending_invoices?
    !(invoices.find_all do |invoice|
      !invoice.is_paid_in_full?
    end.empty?)
  end

  def top_revenue_earners(num)
    invoices.reduce(0) do |sum, amount|
      require "pry"; binding.pry
    end
  end

  def creation_date_items(month)
    if created_at.strftime("%B") == month
      items.count
    end
  end

  def has_one_item?
     items.count == 1
   end
end
