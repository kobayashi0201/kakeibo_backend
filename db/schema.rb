# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_11_23_004134) do
  create_table "ai_recommendations", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "recommend", null: false
    t.string "status", default: "unread", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_ai_recommendations_on_user_id", unique: true
  end

  create_table "calculated_monthly_transactions", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "month", null: false
    t.decimal "total", precision: 15, scale: 2, default: "0.0", null: false
    t.json "total_by_category", null: false
    t.json "percentage_by_category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "month"], name: "index_calculated_monthly_transactions_on_user_id_and_month", unique: true
    t.index ["user_id"], name: "index_calculated_monthly_transactions_on_user_id"
  end

  create_table "calculated_weekly_transactions", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "week_start_date", null: false
    t.decimal "total", precision: 15, scale: 2, default: "0.0", null: false
    t.json "total_by_category", null: false
    t.json "percentage_by_category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "week_start_date"], name: "idx_on_user_id_week_start_date_a562fa14c0", unique: true
    t.index ["user_id"], name: "index_calculated_weekly_transactions_on_user_id"
  end

  create_table "categories", charset: "utf8mb3", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true
  end

  create_table "goals", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "goal_savings", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "current_savings", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "percentage", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_goals_on_user_id", unique: true
  end

  create_table "transactions", charset: "utf8mb3", force: :cascade do |t|
    t.decimal "amount", precision: 10, null: false
    t.date "date", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["user_id"], name: "fk_rails_77364e6416"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ai_recommendations", "users"
  add_foreign_key "calculated_monthly_transactions", "users"
  add_foreign_key "calculated_weekly_transactions", "users"
  add_foreign_key "categories", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "users"
end
