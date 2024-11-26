class AddIndexToCategoriesAgain < ActiveRecord::Migration[8.0]
  def change
    add_index :categories, [ :user_id, :name ], unique: true
  end
end
