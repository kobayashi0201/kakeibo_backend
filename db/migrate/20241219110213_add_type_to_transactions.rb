class AddTypeToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :type, :integer, null: false, default: 0
  end
end
