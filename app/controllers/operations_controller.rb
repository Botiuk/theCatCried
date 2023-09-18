class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]

  def index
    if params[:page]
      session[:operations_index_page] = params[:page]
    end
    @operations = Operation.list_order.page(session[:operations_index_page])
    @categories = Category.search_formhelper
  end

  def search
    @operations = Operation.search_op(params[:category_id]).page(params[:page])
    @search_name = Category.name_from_id(params[:category_id])
  end

  def show
  end

  def new
    @operation = Operation.new(:otype => params[:otype], :odate => Time.now.to_date)
    @categories = Category.ctype_formhelper(@operation)    
  end

  def edit
    @categories = Category.edit_formhelper(@operation)
  end

  def create
    @operation = Operation.new(operation_params)
    @categories = Category.ctype_formhelper(@operation)
      if @operation.save
        redirect_to operation_url(@operation), notice: t('operations.notice.create')   
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      if @operation.update(operation_params)
        redirect_to params[:previous_request], notice: t('operations.notice.update')  
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @operation.destroy
    redirect_to operations_url, notice: t('operations.notice.destroy')
  end

  private
    
    def set_operation
      @operation = Operation.find(params[:id])
    end

    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id, :otype)
    end

end
