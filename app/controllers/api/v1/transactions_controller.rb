class Api::V1::TransactionsController < ActionController::API
  def index
    transactions = Transaction.all
    render json: transactions, status: :ok
  end

  def create
    service = CreateTransactionService.new(transaction_params)
    result = service.create_transaction

    if result.is_a?(Transaction)
      render json: result, status: :created
    else
      render json: { error: result }, status: :unprocessable_entity
    end
  end

  def destroy
    service = DeleteTransactionsService.new(params[:id])
    result = service.delete_transaction

    if result
      render json: { message: 'Transaction deleted' }, status: :ok
    else
      render json: { error: 'Transaction not found' }, status: :not_found
    end
  end

  def destroy_multiple
    if params[:ids].blank?
      render json: { error: 'No IDs provided' }, status: :unprocessable_entity
      return
    end
    service = DeleteTransactionsService.new(params[:ids])
    result = service.delete_transactions
    if result
      render json: { message: 'Transactions deleted' }, status: :ok
    else
      render json: { error: 'Transactions not found' }, status: :not_found
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :description, :user_id, :category_id)
  end
end
