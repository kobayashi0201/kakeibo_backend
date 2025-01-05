require 'rails_helper'

RSpec.describe ExceptMonthlyTransactionService, type: :service do
  before do
    Transaction.destroy_all
    CalculatedMonthlyTransaction.destroy_all

    @user = create(:user)
    @category1 = create(:category)
    @category2 = create(:category, name: '交通費')
    @category3 = create(:category, name: '光熱費')

    @transaction1 = CreateTransactionService.new(transaction_data(1000, '2025-01-01', 'テスト1', 'expense', @user.id, @category1.id)).create_transaction
    @transaction2 = CreateTransactionService.new(transaction_data(2000, '2025-01-02', 'テスト2', 'expense', @user.id, @category2.id)).create_transaction
    @transaction3 = CreateTransactionService.new(transaction_data(1000, '2025-01-03', 'テスト3', 'expense', @user.id, @category3.id)).create_transaction
    @transaction4 = CreateTransactionService.new(transaction_data(1000, '2025-01-04', 'テスト4', 'expense', @user.id, @category2.id)).create_transaction
  end

  describe 'except monthly transaction' do
    def transaction_data(amount, date, description, transaction_type, user_id, category_id)
      {
        'amount': amount,
        'date': date,
        'description': description,
        'transaction_type': transaction_type,
        'user_id': user_id,
        'category_id': category_id
      }
    end

    context 'delete a transaction' do
      it 'calculation result is not 0' do
        ExceptMonthlyTransactionService.new(@transaction2['id']).except_monthly_transations
        expect(CalculatedMonthlyTransaction.first.total).to eq(3000)
        expect(CalculatedMonthlyTransaction.first.total_by_category[@transaction2['category_id'].to_s]).to eq(1000)
        expect(CalculatedMonthlyTransaction.first.percentage_by_category[@transaction2['category_id'].to_s]).to eq(33.33)
      end

      it 'calculation result is 0' do
        ExceptMonthlyTransactionService.new(@transaction1['id']).except_monthly_transations
        expect(CalculatedMonthlyTransaction.first.total).to eq(4000)
        expect(CalculatedMonthlyTransaction.first.total_by_category[@transaction1['category_id'].to_s]).to be_nil
        expect(CalculatedMonthlyTransaction.first.percentage_by_category[@transaction1['category_id'].to_s]).to be_nil
      end
    end

    it 'delete multiple transactions' do
      ExceptMonthlyTransactionService.new([ @transaction2['id'], @transaction3['id'] ]).except_monthly_transations
      expect(CalculatedMonthlyTransaction.first.total).to eq(2000)
      expect(CalculatedMonthlyTransaction.first.total_by_category[@transaction2['category_id'].to_s]).to eq(1000)
      expect(CalculatedMonthlyTransaction.first.total_by_category[@transaction3['category_id'].to_s]).to be_nil
      expect(CalculatedMonthlyTransaction.first.percentage_by_category[@transaction2['category_id'].to_s]).to eq(50)
      expect(CalculatedMonthlyTransaction.first.percentage_by_category[@transaction3['category_id'].to_s]).to be_nil
    end
  end
end
