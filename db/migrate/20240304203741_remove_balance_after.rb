class RemoveBalanceAfter < ActiveRecord::Migration[7.1]
  def change
    remove_column :transactions, :balance_after, :integer
  end
end
