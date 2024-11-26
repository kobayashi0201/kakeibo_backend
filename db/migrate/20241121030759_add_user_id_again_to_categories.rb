class AddUserIdAgainToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :user_id, :integer, null: false
  end
end
