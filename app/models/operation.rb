class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true
  validates :otype, presence: true

  enum :otype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 25
  max_pages 40


  private

  def self.total_amount_new(operation)
    if operation.otype == "outcome"
      $total_amount - operation.amount
    else
      $total_amount + operation.amount
    end
  end

  def self.total_amount
    Operation.where(otype: "income").sum(:amount) - Operation.where(otype: "outcome").sum(:amount)
  end


end
