require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:valid_attributes) { { amount: 1000, date: '2025-01-01', description: 'テスト', user_id: user.id, category_id: category.id } }

  shared_examples 'a transaction with missing attribute' do |attribute|
    it "is not valid without a #{attribute}" do
      transaction = Transaction.new(valid_attributes.merge(attribute => nil))
      expect(transaction).to_not be_valid
      expect(transaction.errors[attribute]).to include("can't be blank")
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      transaction = Transaction.new(valid_attributes)
      expect(transaction).to be_valid
    end

    include_examples 'a transaction with missing attribute', :amount
    include_examples 'a transaction with missing attribute', :date

    it 'is invalid with a negative amount' do
      transaction = Transaction.new(amount: -1000)
      expect(transaction).not_to be_valid
    end

    it 'is invalid with 0 amount' do
      transaction = Transaction.new(amount: 0)
      expect(transaction).not_to be_valid
    end
  end
end
