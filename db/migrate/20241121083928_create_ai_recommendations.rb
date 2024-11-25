class CreateAiRecommendations < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_recommendations do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.text :recommend, null: false
      t.string :status, null: false, default: "unread"

      t.timestamps
    end
    add_index :ai_recommendations, :user_id, unique: true
  end
end
