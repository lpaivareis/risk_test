# frozen_string_literal: true

module Fraud
  class VerifyFraudService < ValidationsService
    attr_reader :transaction

    delegate :transaction_date, :transaction_amount, :user_id, to: :transaction

    def initialize(transaction)
      super()
      @transaction = transaction
    end

    def call
      rules
    end

    private

    def rules
      return 'Approve' unless validations

      update_transaction

      'Reprove'
    end

    def validations
      [
        (weekend?(transaction_date) || night?(transaction_date)) && high_amount?(transaction_amount),
        frequent_user?(user_id),
        recent_refund?(user_id)
      ].count(true) >= 1
    end

    def update_transaction
      return unless validations

      transaction.update(has_cbk: validations)
    end
  end
end
