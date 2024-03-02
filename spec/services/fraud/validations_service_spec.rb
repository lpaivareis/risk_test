# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fraud::ValidationsService, type: :service do
  describe '#recent_refund?' do
    subject { described_class.new.recent_refund?(transaction.user_id) }

    before do
      create_list(:transaction, 3, :with_cbk, user_id: 123_456, transaction_date: 3.hours.ago)
    end

    let(:transaction) { create(:transaction, user_id: 123_456) }

    it 'returns true if there is a recent refund' do
      expect(subject).to be_truthy
    end

    context 'when there is no recent refund' do
      before do
        Transaction.where(user_id: 123_456).update_each(has_cbk: false)
      end

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#weekend?' do
    subject { described_class.new.weekend?(transaction.transaction_date) }

    let(:transaction) { create(:transaction, transaction_date: Time.zone.local(2024, 3, 3, 12, 0, 0)) }

    it 'returns true if the transaction date is on a weekend' do
      expect(subject).to be_truthy
    end

    context 'when the transaction date is not on a weekend' do
      let(:transaction) { create(:transaction, transaction_date: Time.zone.local(2024, 3, 5, 12, 0, 0)) }

      it 'returns false if the transaction date is not on a weekend' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#night?' do
    subject { described_class.new.night?(transaction.transaction_date) }

    let(:transaction) { create(:transaction, transaction_date: Time.zone.local(2024, 3, 3, 23, 0, 0)) }

    it 'returns true if the transaction date is during the night' do
      expect(subject).to be_truthy
    end

    context 'when the transaction date is not during the night' do
      let(:transaction) { create(:transaction, transaction_date: Time.zone.local(2024, 3, 3, 12, 0, 0)) }

      it 'returns false if the transaction date is not during the night' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#high_amount?' do
    subject { described_class.new.high_amount?(transaction.transaction_amount) }

    let(:transaction) { create(:transaction, :high_amount) }

    it 'returns true if the transaction amount is high' do
      expect(subject).to be_truthy
    end

    context 'when the transaction amount is not high' do
      let(:transaction) { create(:transaction) }

      it 'returns false if the transaction amount is not high' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#frequent_user?' do
    subject { described_class.new.frequent_user?(transaction.user_id) }

    before do
      create_list(:transaction, 5, user_id: 123_456, transaction_date: 1.hour.ago)
    end

    let(:transaction) { create(:transaction, user_id: 123_456, transaction_date: 1.hour.ago) }

    it 'returns true if the user is a frequent user' do
      expect(subject).to be_truthy
    end

    context 'when the user is not a frequent user' do
      subject { described_class.new.frequent_user?(transaction.user_id) }

      before do
        Transaction.where(user_id: 123_456).delete_all
      end

      let(:transaction) { create(:transaction, user_id: 123_456) }

      it 'returns false if the user is not a frequent user' do
        expect(subject).to be_falsey
      end
    end
  end
end
