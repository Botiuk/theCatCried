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

  def self.reports_data(start_date, end_date, otype, category_id_out, category_id_in)
    if otype == "outcome"
      category_id = category_id_out
    else
      category_id = category_id_in
    end

    if category_id == "0" 
      Operation.where(odate: start_date..end_date, otype: otype).map { |o| [o.odate.to_s, o.amount] }
    else
      Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).map { |o| [o.odate.to_s, o.amount] }
    end    
  end


end
