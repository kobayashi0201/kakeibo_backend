class ChangeDateColumnTypeInTransactions < ActiveRecord::Migration[8.0]
  def change
    change_column :transactions, :date, :string
  end
end
