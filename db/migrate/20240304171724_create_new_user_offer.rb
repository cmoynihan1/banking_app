class CreateNewUserOffer < ActiveRecord::Migration[7.1]
  def change
    create_table :new_user_offers do |t|
      t.integer :amount

      t.timestamps
    end
  end
end
