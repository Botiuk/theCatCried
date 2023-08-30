class ReportsController < ApplicationController
  def index
    @categories_outcome = Category.reports_formhelper("outcome")
    @categories_income = Category.reports_formhelper("income")
  end

  # def report 
  #   if params[:btn_graph]
  #   redirect_to({
  #     action: "report_by_dates",
  #     start_date: params[:dateFrom],
  #     end_date: params[:dateTo]
  #   })
  #   else
  #   redirect_to({
  #     action: "report_by_category",
  #     start_date: params[:dateFrom],
  #     end_date: params[:dateTo]
  #   })
  # end
# end



  # def report_by_category
  #   @operation = Operation.where(category_id = ?, params[:category_id])
  # end

  def report_by_dates    
    rates_data = Operation.reports_data(params[:start_date], params[:end_date], params[:otype], params[:category_id_out], params[:category_id_in])
    @dates = rates_data.map { |e| e[0] }
    @rates = rates_data.map { |e| e[1] }
  end

end
