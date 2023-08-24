class AddCTypeToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :ctype, :integer
  end
end
