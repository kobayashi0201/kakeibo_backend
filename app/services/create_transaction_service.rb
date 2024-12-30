class CreateTransactionService
  def initialize(transaction_params)
    @transaction_params = transaction_params
  end

  def create_transaction
    transaction = Transaction.new(@transaction_params)

    if transaction.save
      calculate_service = CalculateTransactionService.new(@transaction_params)
      calculate_service.calculate_monthly_transations
      transaction
    else
      transaction.errors
    end
  end
end
