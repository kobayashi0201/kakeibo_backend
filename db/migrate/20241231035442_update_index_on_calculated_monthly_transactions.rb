class UpdateIndexOnCalculatedMonthlyTransactions < ActiveRecord::Migration[8.0]
  def change
    if index_exists?(:calculated_monthly_transactions, [ :user_id, :month ], name: "index_calculated_monthly_transactions_on_user_id_and_month")
      remove_index :calculated_monthly_transactions, name: "index_calculated_monthly_transactions_on_user_id_and_month"
    end
    add_index :calculated_monthly_transactions, [ :user_id, :month, :transaction_type ], unique: true, name: "index_calculated_monthly_transactions_on_uid_month_type"
  end
end
