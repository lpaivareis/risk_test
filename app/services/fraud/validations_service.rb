# frozen_string_literal: true

module Fraud
  class ValidationsService < ApplicationService
    def recent_refund?(user_id)
      Transaction.exists?(user_id:,
                          transaction_date: 3.days.ago..Time.current,
                          has_cbk: true)
    end

    def weekend?(transaction_date)
      transaction_date.saturday? || transaction_date.sunday?
    end

    def night?(transaction_date)
      transaction_date.hour < 6 || transaction_date.hour > 19
    end

    def high_amount?(transaction_amount)
      transaction_amount > 500
    end

    def frequent_user?(user_id)
      Transaction.where(user_id:, transaction_date: 2.hours.ago..Time.zone.now).count > 5
    end
  end
end
