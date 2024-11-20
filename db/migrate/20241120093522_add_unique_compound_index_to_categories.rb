# frozen_string_literal: true

class AddUniqueCompoundIndexToCategories < ActiveRecord::Migration[7.2]
  def change
    add_index :categories, %i[name user_id], unique: true
  end
end
