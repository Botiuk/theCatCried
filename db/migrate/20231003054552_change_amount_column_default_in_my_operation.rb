# frozen_string_literal: true

class ChangeAmountColumnDefaultInMyOperation < ActiveRecord::Migration[7.0]
  def self.up
    change_column :operations, :amount, :decimal, precision: 10, scale: 2, default: nil
  end

  def self.down
    change_column :operations, :amount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
