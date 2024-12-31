class AddTransactionTypeToCalculatedMonthlyTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :calculated_monthly_transactions, :transaction_type, :integer
  end
end
