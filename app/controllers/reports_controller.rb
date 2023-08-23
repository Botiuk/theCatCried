class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    @operation = Operation.where(category_id = ?, params[:category_id])
  end

  def report_by_dates
    @operation = Operation.where(created_at >= start_date, created_at <= end_date, params[:created_at])
  end
end
