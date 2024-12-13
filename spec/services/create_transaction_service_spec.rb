require 'rails_helper'

RSpec.describe CreateTransactionService, type: :service do
  describe 'create' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:transaction_params) do
      { 
        amount: 1000,
        date: '2025-01-01',
        description: 'テスト',
        user_id: user.id,
        category_id: category.id
      }
    end

    it 'create a new transaction' do
      expect{ CreateTransactionService.new(transaction_params).create_transaction }.to change(Transaction, :count).by(1)
    end
  end
end