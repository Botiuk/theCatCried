# frozen_string_literal: true

class AddUserToOperations < ActiveRecord::Migration[7.0]
  def change
    add_reference :operations, :user, foreign_key: true
    change_column_null :operations, :user_id, false
  end
end
