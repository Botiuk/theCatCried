class AddOTypeToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :otype, :integer
  end
end
