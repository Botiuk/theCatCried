class ReportsController < ApplicationController
  def index
    @categories_outcome = Category.reports_formhelper("outcome")
    @categories_income = Category.reports_formhelper("income")
  end
      
  def report_by_category
    report_data_view
    @operation = Operation.reports_data_by_category(@start_date, @end_date, @otype, @category_id)
  end

  def report_by_dates
    report_data_view
    rates_data = Operation.reports_data_by_dates(@start_date, @end_date, @otype, @category_id)
    @dates = rates_data.map { |e| e[0] }
    @rates = rates_data.map { |e| e[1] }
  end

  def report_by_sum
    report_data_view
    @period_sum = Operation.reports_data_by_sum(@start_date, @end_date, @otype, @category_id)
  end

  private

  def report_data_view
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @otype = params[:otype] 
    if @otype == "outcome"
      @category_id = params[:category_id_out]
    else
      @category_id = params[:category_id_in]
    end

    if @category_id != "0"
      @category_name = Category.where(id: @category_id).map { |cat| cat.name }
    end
  

  end

end
