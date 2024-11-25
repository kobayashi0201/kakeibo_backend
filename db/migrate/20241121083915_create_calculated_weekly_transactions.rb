class CreateCalculatedWeeklyTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :calculated_weekly_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.date :week_start_date, null: false
      t.decimal :total, precision: 15, scale: 2, null: false, default: 0.0
      t.json :total_by_category, null: false
      t.json :percentage_by_category, null: false
  
      t.timestamps
    end
    add_index :calculated_weekly_transactions, [:user_id, :week_start_date], unique: true
  end
end
