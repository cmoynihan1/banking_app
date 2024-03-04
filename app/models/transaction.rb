# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :to_user, :class_name => 'User', foreign_key: 'to_account_id', required: false
  belongs_to :from_user, :class_name => 'User', foreign_key: 'from_account_id', required: false

  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }

  TRANSACTION_TYPES = %w[withdrawal deposit transfer]
end
