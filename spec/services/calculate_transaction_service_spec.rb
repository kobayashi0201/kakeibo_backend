require 'rails_helper'

RSpec.describe CalculateTransactionService, type: :service do
  describe 'calculate' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:transaction_params) do
      {
        amount: 1000,
        date: '2025-01-05',
        description: 'テスト',
        transaction_type: 'expense',
        user_id: user.id,
        category_id: category.id
      }
    end

    context 'when a same month data does not exists' do
      it 'creates a new calculated monthly transaction' do
        service = CalculateTransactionService.new(transaction_params)
        expect { service.calculate_monthly_transations }.to change(CalculatedMonthlyTransaction, :count).by(1)
        expect(CalculatedMonthlyTransaction.last.total).to eq(1000)
        expect(CalculatedMonthlyTransaction.last.total_by_category[category.id.to_s]).to eq(1000)
        expect(CalculatedMonthlyTransaction.last.percentage_by_category[category.id.to_s]).to eq(100)
        expect(CalculatedMonthlyTransaction.last.month).to eq(Date.new(2025, 1, 1))
      end
    end

    context 'when a same month data exists' do
      let(:other_category) { Category.create(name: 'その他', user_id: user.id) }
      let(:other_category_transaction_params) do
        {
          amount: 3000,
          date: '2025-01-10',
          description: 'テスト2',
          transaction_type: 'expense',
          user_id: user.id,
          category_id: other_category.id
        }
      end
      let(:other_transaction_params) do
        {
          amount: 3000,
          date: '2025-01-10',
          description: 'テスト2',
          transaction_type: 'expense',
          user_id: user.id,
          category_id: category.id
        }
      end

      it 'calculate transaction without same category' do
        CalculateTransactionService.new(transaction_params).calculate_monthly_transations
        CalculateTransactionService.new(other_category_transaction_params).calculate_monthly_transations
        expect(CalculatedMonthlyTransaction.last.total).to eq(4000)
        expect(CalculatedMonthlyTransaction.last.total_by_category[other_category.id.to_s]).to eq(3000)
        expect(CalculatedMonthlyTransaction.last.percentage_by_category[other_category.id.to_s]).to eq(75)
        expect(CalculatedMonthlyTransaction.last.month).to eq(Date.new(2025, 1, 1))
      end

      it 'calculate transaction with same category' do
        CalculateTransactionService.new(transaction_params).calculate_monthly_transations
        CalculateTransactionService.new(other_transaction_params).calculate_monthly_transations
        expect(CalculatedMonthlyTransaction.last.total).to eq(4000)
        expect(CalculatedMonthlyTransaction.last.total_by_category[category.id.to_s]).to eq(4000)
        expect(CalculatedMonthlyTransaction.last.percentage_by_category[category.id.to_s]).to eq(100)
        expect(CalculatedMonthlyTransaction.last.month).to eq(Date.new(2025, 1, 1))
      end
    end

    context 'when a same transaction_type data does not exists' do
      let(:income_transaction_params) do
        {
          amount: 10000,
          date: '2025-01-15',
          description: 'テスト',
          transaction_type: 'income',
          user_id: user.id,
          category_id: category.id
        }
      end

      it 'creates a new calculated monthly transaction' do
        service = CalculateTransactionService.new(transaction_params).calculate_monthly_transations
        service = CalculateTransactionService.new(income_transaction_params).calculate_monthly_transations
        expect(CalculatedMonthlyTransaction.last.total).to eq(10000)
        expect(CalculatedMonthlyTransaction.last.total_by_category[category.id.to_s]).to eq(10000)
        expect(CalculatedMonthlyTransaction.last.percentage_by_category[category.id.to_s]).to eq(100)
        expect(CalculatedMonthlyTransaction.last.month).to eq(Date.new(2025, 1, 1))
        expect(CalculatedMonthlyTransaction.last.transaction_type).to eq('income')
      end
    end
  end
end
