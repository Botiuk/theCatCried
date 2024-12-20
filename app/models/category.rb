# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :operations, dependent: nil
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, presence: true
  validates :ctype, presence: true

  enum :ctype, { outcome: 0, income: 1 }, prefix: true

  paginates_per 20
  max_pages 10



  def self.list_order(user)
    Category.where(user_id: user).order(:name)
  end

  def self.search_formhelper(user)
    Category.where(user_id: user).order(:name).pluck(:name, :id)
  end

  def self.ctype_formhelper(operation, user)
    if operation.otype == 'outcome'
      Category.where(ctype: 'outcome', user_id: user).order(:name).pluck(:name, :id)
    else
      Category.where(ctype: 'income', user_id: user).order(:name).pluck(:name, :id)
    end
  end

  def self.reports_formhelper(otype, user)
    if otype == 'outcome'
      [[I18n.t('models.category.reports-otype.outcome'),
        '0']] + Category.where(ctype: 'outcome', user_id: user).order(:name).pluck(:name, :id)
    else
      [[I18n.t('models.category.reports-otype.income'),
        '0']] + Category.where(ctype: 'income', user_id: user).order(:name).pluck(:name, :id)
    end
  end

  def self.name_from_id(id)
    Category.where(id: id).pluck(:name).join
  end
end
