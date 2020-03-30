# frozen_string_literal: true

class AddBalanceToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column(
      :accounts,
      :balance,
      :decimal,
      precision: 18,
      scale: 2,
      default: 0,
      null: false
    )
  end
end
