class Api::V1::TransactionsController < ActionController::API
  def create
    service = CreateTransactionService.new(transaction_params)
    result = service.create_transaction

    if result.is_a?(Transaction)
      render json: result, status: :created
    else
      render json: { error: result }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :description, :user_id, :category_id)
  end
end
