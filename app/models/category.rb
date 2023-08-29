class Category < ApplicationRecord

  has_many :operations

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :ctype, presence: true

  enum :ctype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 10
  max_pages 50


private

  def self.ctype_formhelper(operation)
    if operation.otype == "outcome" || operation == "outcome"
      Category.where(ctype: "outcome").order(:name).map { |cat| [cat.name, cat.id] }
    else
      Category.where(ctype: "income").order(:name).map { |cat| [cat.name, cat.id] }
    end
  end

  def self.edit_formhelper(operation)
    Category.where(id: operation.category_id).map { |cat| [cat.name, cat.id] } + Category.ctype_formhelper(operation)
  end

  def self.reports_formhelper(otype)
    if otype == "outcome"
      [ ["Всі категорії витрат", 0] ] + Category.where(ctype: "outcome").order(:name).map { |cat| [cat.name, cat.id] }
    else
      [ ["Всі категорії доходів", 0] ] + Category.where(ctype: "income").order(:name).map { |cat| [cat.name, cat.id] }
    end
  end
  
end
