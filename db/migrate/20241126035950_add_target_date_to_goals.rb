class AddTargetDateToGoals < ActiveRecord::Migration[8.0]
  def change
    add_column :goals, :target_date, :date
  end
end
