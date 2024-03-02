# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  describe '#import_transactions' do
    subject(:import_transactions) { post :import_transactions, params: { file:, limit: 100 } }

    let(:file) { fixture_file_upload('spec/fixtures/files/transactional-sample.csv', 'text/csv') }

    it 'returns status 200' do
      import_transactions

      expect(response).to have_http_status(:ok)
    end

    it 'imports transactions successfully' do
      import_transactions

      expect(response.body).to eq({ message: 'Transactions imported successfully' }.to_json)
    end
  end

  describe '#check_transaction' do
    subject(:process_transaction) { post :check_transaction, params: { transaction: transaction_params } }

    before do
      allow(ProcessTransactionService).to receive(:call).and_return(service_response)
    end

    let(:transaction_params) do
      {
        transaction_id: '123',
        merchant_id: '456',
        user_id: '789',
        card_number: '123456789',
        transaction_date: '2022-01-01',
        transaction_amount: 100.0,
        device_id: 'abc123'
      }
    end

    let(:service_response) do
      {
        transaction_id: '123',
        recommendation: 'Approve'
      }
    end

    it 'returns status 200' do
      process_transaction

      expect(response).to have_http_status(:ok)
    end

    it 'processes transaction successfully' do
      process_transaction

      expect(response.body).to eq(service_response.to_json)
    end
  end
end
