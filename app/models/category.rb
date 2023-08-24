class Category < ApplicationRecord
  has_many :operations

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :ctype, presence: true

  enum :ctype, { outcome: 0, income: 1 }, prefix: true
end
