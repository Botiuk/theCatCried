# frozen_string_literal: true

class CreateOperations < ActiveRecord::Migration[7.0]
  def change
    create_table :operations do |t|
      t.decimal :amount, null: false
      t.datetime :odate, null: false
      t.string :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
