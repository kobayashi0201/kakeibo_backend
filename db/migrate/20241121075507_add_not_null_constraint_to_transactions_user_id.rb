class AddNotNullConstraintToTransactionsUserId < ActiveRecord::Migration[8.0]
  def change
    change_column_null :transactions, :user_id, false
  end
end
