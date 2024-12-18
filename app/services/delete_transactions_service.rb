 class DeleteTransactionsService
  def initialize(transaction_ids)
    @transaction_ids = transaction_ids
  end

  def delete_transaction
    transaction = Transaction.find_by(id: @transaction_ids)
    if transaction.nil?
      return false
    else
      transaction.destroy
      return true
    end
  end

  def delete_transactions
    transactions = Transaction.where(id: @transaction_ids)
    if transactions.empty?
      return false
    else
      transactions.destroy_all
      return true
    end
  end
end
