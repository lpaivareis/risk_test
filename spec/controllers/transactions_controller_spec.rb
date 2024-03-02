# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  describe '#import_transactions' do
    let(:file) { fixture_file_upload('spec/fixtures/files/transactional-sample.csv', 'text/csv') }
    let(:limit) { 100 }

    it 'imports transactions successfully' do
      post :import_transactions, params: { file:, limit: }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ message: 'Transactions imported successfully' }.to_json)
    end
  end

  describe '#check_transaction' do
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

    it 'processes transaction successfully' do
      allow(ProcessTransactionService).to receive(:call).and_return({
                                                                      transaction_id: '123',
                                                                      recommendation: 'Approve'
                                                                    })

      post :check_transaction, params: { transaction: transaction_params }

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ transaction_id: '123', recommendation: 'Approve' }.to_json)
    end
  end
end
