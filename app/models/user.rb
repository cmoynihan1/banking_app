class User < ApplicationRecord
  has_secure_password

  validates :username , presence: true, uniqueness: true

  has_many :incoming_transactions, :class_name => 'Transaction', :foreign_key => 'to_account_id'
  has_many :outgoing_transactions, :class_name => 'Transaction', :foreign_key => 'from_account_id'

  def transactions
    self.outgoing_transactions.or(self.incoming_transactions)
  end
end
