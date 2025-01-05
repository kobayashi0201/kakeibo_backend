require "pry"
class DeleteTransactionsService
  def initialize(transaction_ids)
    @transaction_ids = transaction_ids
  end

  def delete_transaction
    transaction = Transaction.find_by(id: @transaction_ids)
    service = ExceptMonthlyTransactionService.new(@transaction_ids)
    if transaction.nil?
      false
    else
      service.except_monthly_transations
      transaction.destroy
      true
    end
  end

  def delete_transactions
    transactions = Transaction.where(id: @transaction_ids)
    service = ExceptMonthlyTransactionService.new(@transaction_ids)
    if transactions.empty?
      false
    else
      service.except_monthly_transations
      transactions.destroy_all
      true
    end
  end
end
