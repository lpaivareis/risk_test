# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fraud::VerifyFraudService do
  describe '#call' do
    let!(:transaction) { create(:transaction) }
    let(:service) { described_class.new(transaction) }

    context 'when reprove transaction' do
      before do
        allow(service).to receive(:validations).and_return(true)
      end

      it 'updates the transaction' do
        expect(service).to receive(:update_transaction)
        service.call
      end

      it 'returns "Reprove"' do
        expect(service.call).to eq('Reprove')
      end
    end

    context 'when approve transaction' do
      before do
        allow(service).to receive(:validations).and_return(false)
      end

      it 'does not update the transaction' do
        expect(service).not_to receive(:update_transaction)
        service.call
      end

      it 'returns "Approve"' do
        expect(service.call).to eq('Approve')
      end
    end
  end
end
