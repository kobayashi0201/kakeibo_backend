class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.decimal :goal_savings, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :current_savings, precision: 15, scale: 2, null: false, default: 0.0
      t.decimal :percentage, precision: 5, scale: 2, null: false, default: 0.0

      t.timestamps
    end
    add_index :goals, :user_id, unique: true
  end
end
