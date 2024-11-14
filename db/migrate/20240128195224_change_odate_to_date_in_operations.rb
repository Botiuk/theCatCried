# frozen_string_literal: true

class ChangeOdateToDateInOperations < ActiveRecord::Migration[7.0]
  def self.up
    change_column :operations, :odate, :date
  end

  def self.down
    change_column :operations, :odate, :datetime
  end
end
