# frozen_string_literal: true

class AddFavoriteLocaleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :favorite_locale, :string, null: false, default: 'en'
  end
end
