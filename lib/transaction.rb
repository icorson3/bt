class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(transaction_hash)
    @id = transaction_hash[:id]
    @invoice_id = transaction_hash[:invoice_id]
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result]
    @created_at = transaction_hash[:created_at]
    @updated_at = transaction_hash[:updated_at]
  end
end
# t = Transaction.new({
#   :id => 6,
#   :invoice_id => 8,
#   :credit_card_number => "4242424242424242",
#   :credit_card_expiration_date => "0220",
#   :result => "success",
#   :created_at => Time.now,
#   :updated_at => Time.now
# })