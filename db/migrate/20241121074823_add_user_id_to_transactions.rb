class AddUserIdToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :user_id, :bigint
    change_column_null :transactions, :amount, false
    change_column_null :transactions, :date, false
    change_column_null :transactions, :category, false
    add_foreign_key :transactions, :users
  end
end
