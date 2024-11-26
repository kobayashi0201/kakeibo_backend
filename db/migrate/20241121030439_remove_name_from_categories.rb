class RemoveNameFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :categories, :name, :string
  end
end
