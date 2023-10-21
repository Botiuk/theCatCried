class Operation < ApplicationRecord

  belongs_to :category
  belongs_to :user


  validates :amount, presence: true
  validates :odate, presence: true
  validates :otype, presence: true

  enum :otype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 20
  max_pages 50


  private

    def self.total_amount(user)
      Operation.where(user_id: user, otype: "income").sum(:amount) - Operation.where(user_id: user, otype: "outcome").sum(:amount)
    end

    def self.list_order(user)
      Operation.where(user_id: user).order(:odate,:id).reverse_order
    end

    def self.search_op(category_id)
      Operation.where(category_id: category_id).order(:odate,:id).reverse_order
    end

    def self.cat_destroy(category_id)
      Operation.where(category_id: category_id).size
    end

    def self.reports_data_by_category(start_date, end_date, otype, category_id, user_id)
      if category_id == "0"
        Operation.where(odate: start_date..end_date, otype: otype, user_id: user_id).group(:category_id)
        .sum(:amount).map { |op| [Category.where(id: op[0]).pluck(:name).join, op[1]] }
      else
        Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).group(:category_id)
        .sum(:amount).map { |op| [Category.where(id: op[0]).pluck(:name).join, op[1]] }
      end
    end

    def self.reports_data_by_dates(start_date, end_date, otype, category_id, user_id)
      if category_id == "0"
        Operation.where(odate: start_date..end_date, otype: otype, user_id: user_id).order(:odate)
        .group(:odate).sum(:amount)
      else
        Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).order(:odate)
        .group(:odate).sum(:amount)
      end
    end

    def self.reports_sum(start_date, end_date, otype, category_id, user_id)
      if category_id == "0"
        Operation.where(odate: start_date..end_date, otype: otype, user_id: user_id).sum(:amount)
      else
        Operation.where(odate: start_date..end_date, otype: otype, category_id: category_id).sum(:amount)
      end
    end

end
