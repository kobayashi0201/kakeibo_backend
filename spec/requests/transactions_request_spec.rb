require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  before do
    Transaction.delete_all
    CalculatedMonthlyTransaction.delete_all
  end

  def send_get_request
    get "#{@base_url}/api/v1/transactions"
  end

  def send_post_request(params)
    post "#{@base_url}/api/v1/transactions", params: params
  end

  def send_delete_request(params)
    delete "#{@base_url}/api/v1/transactions/#{params}"
  end

  def send_delete_multiple_request(params)
    delete "#{@base_url}/api/v1/transactions/destroy_multiple", params: params
  end

  describe 'GET /index' do
    it 'return a 200 status code' do
      send_get_request
      expect(response).to have_http_status(:ok)
    end

    it 'return all transactions in JSON format' do
      create_list(:transaction, 10)
      send_get_request
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end
  end

  describe 'POST /create' do
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

    it 'return a 201 status code' do
      send_post_request(transaction_params)
      expect(response).to have_http_status(:created)
    end

    it 'create a new transaction and update CalculatedMonthlyTransaction' do
      expect { send_post_request(transaction_params) }.to change(Transaction, :count).by(1)
      expect(CalculatedMonthlyTransaction.last.total).to eq(1000)
      expect(CalculatedMonthlyTransaction.last.total_by_category[category.id.to_s]).to eq(1000)
    end

    it 'created transaction in JSON format' do
      send_post_request(transaction_params)
      json = JSON.parse(response.body)
      expect(json['amount']).to eq(1000)
      expect(json['date']).to eq('2025-01-01')
      expect(json['description']).to eq('テスト')
      expect(json['transaction_type']).to eq('expense')
    end

    it 'return a 422 status code' do
      transaction_params[:transaction][:amount] = nil
      send_post_request(transaction_params)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /destroy' do
    before do
      @user = create(:user)
      @category = create(:category)
      @transaction = Transaction.create!(
        amount: 1000,
        date: '2025-01-01',
        description: 'delete test',
        transaction_type: 'expense',
        user_id: @user.id,
        category_id: @category.id
      )
      @calculated_monthly_transaction = CalculatedMonthlyTransaction.create!(
        month: '2025-01-01',
        total: 1000,
        total_by_category: { @category.id.to_s => 1000 },
        percentage_by_category: { @category.id.to_s => 100.0 },
        transaction_type: 'expense',
        user_id: @user.id
      )
    end

    it 'return a 200 status code' do
      send_delete_request(@transaction['id'])
      expect(response).to have_http_status(:ok)
    end

    it 'delete a transaction' do
      send_delete_request(@transaction['id'])
      expect(Transaction.count).to eq(0)
      expect(CalculatedMonthlyTransaction.count).to eq(0)
    end

    it 'return a 404 status code' do
      send_delete_request(999)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /destroy_multiple' do
    before do
      @transactions = create_list(:transaction, 5, category_id: create(:category).id, user_id: create(:user).id)
      @calculated_monthly_transactions = CalculatedMonthlyTransaction.create!(
        month: '2025-01-01',
        total: 5000,
        total_by_category: { @transactions[0].category_id.to_s => 5000 },
        percentage_by_category: { @transactions[0].category_id.to_s => 100.0 },
        transaction_type: 'expense',
        user_id: @transactions[0].user_id
      )
    end

    it 'return a 200 status code' do
      send_delete_multiple_request(ids: @transactions[0..2].pluck(:id))
      expect(response).to have_http_status(:ok)
    end

    it 'delete transactions' do
      send_delete_multiple_request(ids: @transactions[0..2].pluck(:id))
      expect(Transaction.count).to eq(2)
      expect(CalculatedMonthlyTransaction.count).to eq(1)
      expect(CalculatedMonthlyTransaction.first.total).to eq(2000)
    end

    it 'return a 404 status code' do
      send_delete_multiple_request(ids: [ 998, 999 ])
      expect(response).to have_http_status(:not_found)
    end

    it 'return a 422 status code' do
      send_delete_multiple_request(ids: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
