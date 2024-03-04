# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :to_account, :class_name => 'User', foreign_key: 'to_account_id', required: false
  belongs_to :from_account, :class_name => 'User', foreign_key: 'from_account_id', required: false

  TRANSACTION_TYPES = %w[withdrawal deposit transfer]

  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
  validates :amount, presence: true
end
