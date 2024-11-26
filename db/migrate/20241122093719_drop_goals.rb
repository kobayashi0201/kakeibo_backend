class DropGoals < ActiveRecord::Migration[8.0]
  def change
    drop_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :goal_savings, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :current_savings, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :percentage, precision: 5, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
