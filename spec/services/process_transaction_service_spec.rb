# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessTransactionService do
  describe '#call' do
    let(:transaction_params) do
      {
        transaction_id: 2_342_357,
        merchant_id: 29_744,
        user_id: 97_051,
        card_number: '434505******9116',
        transaction_date: '2019-11-31T23:16:32.812632',
        transaction_amount: 373,
        device_id: 285_475
      }
    end
    let(:service) { described_class.new(transaction_params) }

    before do
      allow(Fraud::VerifyFraudService).to receive(:call).and_return('Approve')
    end

    it 'returns the response' do
      expect(service.call).to eq({
                                   transaction_id: 2_342_357,
                                   recommendation: 'Approve'
                                 })
    end

    context 'when the transaction is not approved' do
      before do
        allow(Fraud::VerifyFraudService).to receive(:call).and_return('Reprove')
      end

      it 'returns the response' do
        expect(service.call).to eq({
                                     transaction_id: 2_342_357,
                                     recommendation: 'Reprove'
                                   })
      end
    end
  end
end
