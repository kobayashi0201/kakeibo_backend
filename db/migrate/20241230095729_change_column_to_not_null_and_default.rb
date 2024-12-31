class ChangeColumnToNotNullAndDefault < ActiveRecord::Migration[8.0]
  def change
    change_column :calculated_monthly_transactions, :transaction_type, :integer, null: false, default: 0
  end
end
