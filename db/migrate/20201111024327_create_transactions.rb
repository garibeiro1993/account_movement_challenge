class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :account
      t.integer :amount

      t.timestamps
    end
  end
end
