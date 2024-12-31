class UpdateIndexOnCalculatedWeeklyTransactions < ActiveRecord::Migration[8.0]
  def change
    if index_exists?(:calculated_weekly_transactions, [ :user_id, :week_start_date ], name: "idx_on_user_id_week_start_date_a562fa14c0")
      remove_index :calculated_weekly_transactions, name: "idx_on_user_id_week_start_date_a562fa14c0"
    end
    add_index :calculated_weekly_transactions, [ :user_id, :week_start_date, :transaction_type ], unique: true, name: "index_calculated_weekly_transactions_on_uid_week_start_date_type"
  end
end
