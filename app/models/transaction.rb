class Transaction < ApplicationRecord
    belongs_to :user
    belongs_to :category
    enum :transaction_type, { expense: 0, income: 1 }

    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :date, presence: true
    validates :transaction_type, presence: true
end
