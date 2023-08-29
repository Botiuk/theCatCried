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

  def self.reports_data(*reports)
    start_date = params[:start_date]
    end_date = params[:end_date]
    otype_report = params[:otype_report]
    cat_id_report = params[:cat_id_report]
    if cat_id_report == 0 
      Operation.where(odate: start_date..end_date, otype: otype_report)
      .group(:odate.to_date).sum(:amount).map { |o| [o.odate.to_s, o.amount] }
    else
      Operation.where(odate: start_date..end_date, otype: otype_report, category_id: cat_id_report)
      .group(:odate.to_date).sum(:amount).map { |o| [o.odate.to_s, o.amount] }
    end

  end


end
