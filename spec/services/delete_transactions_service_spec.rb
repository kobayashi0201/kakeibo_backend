require 'rails_helper'

RSpec.describe DeleteTransactionsService, type: :service do
  describe 'destroy' do
    let(:transaction) { create(:transaction) } 

    it 'delete a transaction' do
      expect { DeleteTransactionsService.new(transaction.id).delete_transaction }.to change(Transaction, :count).by(0)
    end
  end

  describe 'destroy_multiple' do
    let(:transactions) { create_list(:transaction, 10) }

    it 'delete a transaction' do
      expect { DeleteTransactionsService.new(transactions[0..4].pluck(:id)).delete_transactions }.to change(Transaction, :count).by(5)
    end
  end
end
