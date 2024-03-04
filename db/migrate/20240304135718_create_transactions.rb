class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.integer :amount
      t.integer :balance_after
      t.references :from_account, index: true, foreign_key: { to_table: :users }
      t.references :to_account, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
