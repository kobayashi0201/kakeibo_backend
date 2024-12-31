class AddTransactionTypeToCalculatedWeeklyTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :calculated_weekly_transactions, :transaction_type, :integer
  end
end
