class ReportsController < ApplicationController
  def index
  end

  # def report_by_category
  #   @operation = Operation.where(category_id = ?, params[:category_id])
  # end

  def report_by_dates
    rates_data = Operation.where(created_at >= start_date, created_at <= end_date, params[:created_at]).map { |o| [o.odate.to_s, o.amount] }
    @dates = rates_data.map { |e| e[0] }
    @rates = rates_data.map { |e| e[1] }
  end

end
