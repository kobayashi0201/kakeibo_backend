class CreateCalculatedMonthlyTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :calculated_monthly_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.date :month, null: false
      t.decimal :total, precision: 15, scale: 2, null: false, default: 0.0
      t.json :total_by_category, null: false
      t.json :percentage_by_category, null: false

      t.timestamps
    end
    add_index :calculated_monthly_transactions, [ :user_id, :month ], unique: true
  end
end
