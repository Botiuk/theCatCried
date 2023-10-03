class ChangeAmountColumnDefaultInMyOperation < ActiveRecord::Migration[7.0]
  def change
    change_column_default :operations, :amount, nil
  end
end
