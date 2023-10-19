class Category < ApplicationRecord

  has_many :operations
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :ctype, presence: true

  enum :ctype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 20
  max_pages 10


  private

    def self.list_order(user)
      Category.where(user_id: user).order(:name)
    end

    def self.search_formhelper(user)
      Category.where(user_id: user).order(:name).pluck(:name, :id)
    end

    def self.ctype_formhelper(operation, user)
      if operation.otype == "outcome"
        Category.where(ctype: "outcome", user_id: user).order(:name).pluck(:name, :id)
      else
        Category.where(ctype: "income", user_id: user).order(:name).pluck(:name, :id)
      end
    end

    def self.edit_formhelper(operation, user)
      Category.where(id: operation.category_id).pluck(:name, :id) + self.ctype_formhelper(operation, user)
    end

    def self.reports_formhelper(otype, user)
      if otype == "outcome"
        [ [I18n.t('models.category.reports-otype.outcome'), "0"] ] + Category.where(ctype: "outcome", user_id: user).order(:name).pluck(:name, :id)
      else
        [ [I18n.t('models.category.reports-otype.income'), "0"] ] + Category.where(ctype: "income", user_id: user).order(:name).pluck(:name, :id)
      end
    end

    def self.name_from_id(id)
      Category.where(id: id).pluck(:name).join
    end

end
