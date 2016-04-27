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
#item_by_item_id
  def invoices
    merchant_array.find_invoices_by_merchant_id(self.id)
  end

  # quantity_hash = merchant_invoice_items.each_with_object(Hash.new(0)) { |invoice_item, quantity_hash| quantity_hash[invoice_item.item_id] += invoice_item.quantity }

  # def invoice_items
  #   invoices.map do |invoice|
  #     invoice.invoice_items
  #   end
  # end

  def invoice_item_max
    invoice_items.max_by { |invoice_item| invoice_item.quantity }
  end

  def most_sold_item
    most_sold_invoice_item = invoice_items.find_all do |invoice_item|
      invoice_item.quantity == invoice_item_max.quantity
    end
    # most_sold_invoice_item.map do |invoice_item|
    #   items.flatten.find_by_id(invoice_item.item_id)
    # end

    items.max_by do |item|
      item.quantity_sold
    end
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

   def invoice_item_ids
     invoice_items.group_by { |invoice_item| invoice_item.item_id }.keys.uniq
   end

    def invoice_items
      invoices.map do |invoice|
        invoice.invoice_items
      end.flatten
    end

    def weighted_array_by_invoice_item_occurrences
      array = []
      invoice_items.each do |invoice_item|
        q = invoice_item.quantity
      q.times do
        array << invoice_item.item_id
      end
      array
    end
  end
  #from hash, find value with highest. Go and find

  def find_quantities_of_occurrences(id)
    weighted_array_by_invoice_item_occurrences.item_id.find_all do |instance|
      instance.item_id == id
    end
  end

  def hash_builder_by_item_id
    weighted_array_by_invoice_item_occurrences.group_by do |invoice_item|
      find_quantities_of_occurrences(invoice_item.item_id).length
    end
  end

   #by merchant_id, can call merchant.invoices. Only want successful invoices, want to find quantity. From each successful invoices, find invoice items.

   #Longer array has each invoice item represented for as many times as there is that quantity. Once had, group_by quantity, create hash. Group by amount item_id appeared in array represented by quantity.

   #from there, sort by key, highest value key; invoice items associated with key. Items based on invoice item_id
   #multiple may be sold, so must find


  #  def find_total_quantity_of_item_id
  #    invoice_item_ids.sort_by  {|item_id| }
  #    #go through invoices and find each instance that item appears
     #return quantity for each instance in which it appears
     #reduce that quantity, and place in array of all quantities
     #find the highest number of these quantities -- that is the max
     #from the highest number, convert back into item

end
