FactoryBot.define do
  factory :transaction do
    amount { 1000 }
    date { '2025-01-01' }
    description { 'テスト' }
    transaction_type { 'expense' }
    user
    category
  end
end
