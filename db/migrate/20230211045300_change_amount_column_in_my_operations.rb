# frozen_string_literal: true

class ChangeAmountColumnInMyOperations < ActiveRecord::Migration[7.0]
  def change
    change_column :operations, :amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
