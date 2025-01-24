require 'rails_helper'

RSpec.describe 'CalculatedMonthlyTransactions API', type: :request do
  before do
    CalculatedMonthlyTransaction.delete_all
  end

  describe 'GET /index' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:transaction_params) do
      {
        transaction: {
          amount: 1000,
          date: '2025-01-01',
          description: 'テスト',
          transaction_type: 'expense',
          user_id: user.id,
          category_id: category.id
        }
      }
    end

    def send_get_request
      get "#{@base_url}/api/v1/calculated_monthly_transactions"
    end

    def send_transaction_post_request(params)
      post "#{@base_url}/api/v1/transactions", params: params
    end

    it 'return a 200 status code' do
      send_get_request
      expect(response).to have_http_status(:ok)
    end

    it 'return all calculated monthly transactions in JSON format' do
      send_transaction_post_request(transaction_params)
      send_get_request
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
  end
end
