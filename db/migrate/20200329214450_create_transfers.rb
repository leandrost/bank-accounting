class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.references(
        :source_account,
        index: true,
        foreign_key: { to_table: :accounts }
      )
      t.references(
        :destination_account,
        index: true,
        foreign_key: { to_table: :accounts }
      )
      t.decimal :amount, precision: 18, scale: 2

      t.timestamps
    end
  end
end
