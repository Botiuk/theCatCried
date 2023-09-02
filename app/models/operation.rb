class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true
  validates :otype, presence: true

  enum :otype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 20
  max_pages 50


  private

  def self.total_amount
    Operation.where(otype: "income").sum(:amount) - Operation.where(otype: "outcome").sum(:amount)
  end

  def self.reports_data_by_category(start_date, end_date, otype, category_id)    
    if category_id == "0" 
      Operation.where(odate: start_date..end_date, otype: otype).group(:category_id)
      .sum(:amount).map { |op| [Category.where(id: op[0]).pluck(:name).join, op[1]] }
    else
      Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).group(:category_id)
      .sum(:amount).map { |op| [Category.where(id: op[0]).pluck(:name).join, op[1]] }
    end    
  end

  def self.reports_data_by_dates(start_date, end_date, otype, category_id)
    if category_id == "0" 
      Operation.where(odate: start_date..end_date, otype: otype).order(:odate)
      .group(:odate).sum(:amount).map { |op| [op[0].to_date.to_s, op[1]] }
    else
      Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).order(:odate)
      .group(:odate).sum(:amount).map { |op| [op[0].to_date.to_s, op[1]] }
    end    
  end

  def self.reports_data_by_sum(start_date, end_date, otype, category_id)
    if category_id == "0" 
      Operation.where(odate: start_date..end_date, otype: otype).sum(:amount)
    else
      Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).sum(:amount)
    end   
  end

end
