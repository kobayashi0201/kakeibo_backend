class CalculatedWeeklyTransaction < ApplicationRecord
    belongs_to :user
    enum :transaction_type, { expense: 0, income: 1 }

    validates :transaction_type, presence: true
end
