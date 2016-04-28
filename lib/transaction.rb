class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result, :created_at, :updated_at,
              :transaction_array

  def initialize(trans_hash, transaction_array = nil)
    @id = trans_hash[:id]
    @invoice_id = trans_hash[:invoice_id]
    @credit_card_number = trans_hash[:credit_card_number]
    @credit_card_expiration_date = trans_hash[:credit_card_expiration_date]
    @result = trans_hash[:result]
    @created_at = trans_hash[:created_at]
    @updated_at = trans_hash[:updated_at]
    @transaction_array = transaction_array
  end

  def invoice
    transaction_array.find_invoice_by_transaction_id(self.id)
  end
end
