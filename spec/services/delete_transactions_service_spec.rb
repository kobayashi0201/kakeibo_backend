require 'rails_helper'

RSpec.describe DeleteTransactionsService, type: :service do
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

  describe 'destroy' do
    it 'delete a transaction' do
      expect { DeleteTransactionsService.new(@transaction1.id).delete_transaction }.to change(Transaction, :count).by(-1)
    end

    it 'calls ExceptTransactionService to update CalculatedMonthlyTransactions' do
      except_service = instance_double("ExceptMonthlyTransactionService")
      allow(ExceptMonthlyTransactionService).to receive(:new).and_return(except_service)
      allow(except_service).to receive(:except_monthly_transations)

      DeleteTransactionsService.new(@transaction1.id).delete_transaction

      expect(ExceptMonthlyTransactionService).to have_received(:new).with(@transaction1.id)
      expect(except_service).to have_received(:except_monthly_transations)
    end
  end

  describe 'destroy_multiple' do
    it 'delete a transaction' do
      expect { DeleteTransactionsService.new([ @transaction1.id, @transaction2.id ]).delete_transactions }.to change(Transaction, :count).by(-2)
    end

    it 'calls ExceptTransactionService to update CalculatedMonthlyTransactions for multiple transactions' do
      except_service = instance_double("ExceptMonthlyTransactionService")
      allow(ExceptMonthlyTransactionService).to receive(:new).and_return(except_service)
      allow(except_service).to receive(:except_monthly_transations)

      DeleteTransactionsService.new([ @transaction1.id, @transaction2.id ]).delete_transactions

      expect(ExceptMonthlyTransactionService).to have_received(:new).with([ @transaction1.id, @transaction2.id ])
      expect(except_service).to have_received(:except_monthly_transations)
    end
  end
end
