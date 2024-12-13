class User < ApplicationRecord
    has_many :categories, dependent: :destroy
    has_many :transactions, dependent: :destroy
    has_many :calculated_monthly_transactions, dependent: :destroy
    has_many :calculated_weekly_transactions, dependent: :destroy
    has_one :goal, dependent: :destroy
    has_many :ai_recommendation, dependent: :destroy
end
