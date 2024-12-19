 class DeleteTransactionsService
  def initialize(transaction_ids)
    @transaction_ids = transaction_ids
  end

  def delete_transaction
    transaction = Transaction.find_by(id: @transaction_ids)
    if transaction.nil?
      false
    else
      transaction.destroy
      true
    end
  end

  def delete_transactions
    transactions = Transaction.where(id: @transaction_ids)
    if transactions.empty?
      false
    else
      transactions.destroy_all
      true
    end
  end
 end
