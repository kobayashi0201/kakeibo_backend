class Api::V1::CalculatedMonthlyTransactionsController < ActionController::API
  def index
    calculated_monthly_transactions = CalculatedMonthlyTransaction.all
    render json: calculated_monthly_transactions, status: :ok
  end
end
