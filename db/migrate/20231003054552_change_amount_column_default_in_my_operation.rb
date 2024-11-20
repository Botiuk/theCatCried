# frozen_string_literal: true

class ChangeAmountColumnDefaultInMyOperation < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:operations, :amount, from: 0.0, to: nil)
  end
end
