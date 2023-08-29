class ReportsController < ApplicationController
  def index
    @categories_outcome = Category.reports_formhelper("outcome")
    @categories_income = Category.reports_formhelper("income")
  end

  # def report_by_category
  #   @operation = Operation.where(category_id = ?, params[:category_id])
  # end

  def report_by_dates
    rates_data = Operation.reports_data(params[:start_date], params[:end_date], params[:otype_report], params[:cat_id_report])
    @dates = rates_data.map { |e| e[0] }
    @rates = rates_data.map { |e| e[1] }
  end

end
