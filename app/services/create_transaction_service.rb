class CreateTransactionService
  def initialize(transaction_params)
    @transaction_params = transaction_params
  end

  def create_transaction
    transaction = Transaction.new(@transaction_params)

    if transaction.save
      transaction
    else
      transaction.errors
    end
  end
end
