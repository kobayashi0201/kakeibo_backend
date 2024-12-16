require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:transaction_params) do
      {
        transaction: {
          amount: 1000,
          date: '2025-01-01',
          description: 'テスト',
          user_id: user.id,
          category_id: category.id
        }
      }
    end

    def send_post_request(params)
      post "#{@base_url}/api/v1/transactions", params: params
    end

    it 'return a 201 status code' do
      send_post_request(transaction_params)
      expect(response).to have_http_status(:created)
    end

    it 'create a new transaction' do
      expect { send_post_request(transaction_params) }.to change(Transaction, :count).by(1)
    end

    it 'created transaction in JSON format' do
      send_post_request(transaction_params)
      json = JSON.parse(response.body)
      expect(json['amount']).to eq(1000)
      expect(json['date']).to eq('2025-01-01')
      expect(json['description']).to eq('テスト')
    end
  end
end
