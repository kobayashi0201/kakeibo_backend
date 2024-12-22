require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  before do
    Transaction.delete_all
    Category.delete_all
  end

  describe 'GET /index' do
    def send_get_request
      get "#{@base_url}/api/v1/categories"
    end

    it 'return a 200 status code' do
      send_get_request
      expect(response).to have_http_status(:ok)
    end

    it 'return all categories in JSON format' do
      create_list(:category, 10)
      send_get_request
      json = JSON.parse(response.body)
      expect(json.size).to eq(10)
    end
  end
end
