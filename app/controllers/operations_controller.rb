# frozen_string_literal: true

class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]

  def index
    session[:operations_index_page] = params[:page] if params[:page]
    @operations = Operation.list_order(current_user.id).page(session[:operations_index_page])
    @categories = Category.search_formhelper(current_user.id)
  end

  def search
    if params[:category_id].blank?
      redirect_to operations_url, alert: t('operations.alert.search')
    else
      @operations = Operation.search_op(params[:category_id]).page(params[:page])
      @category = Category.find(params[:category_id])
    end
  end

  def show; end

  def new
    @operation = Operation.new(otype: params[:otype], odate: Time.zone.now.to_date)
    @categories = Category.ctype_formhelper(@operation, current_user.id)
  end

  def edit
    @categories = Category.ctype_formhelper(@operation, current_user.id)
  end

  def create
    @operation = Operation.new(operation_params)
    @categories = Category.ctype_formhelper(@operation, current_user.id)
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
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def operation_params
    params.require(:operation).permit(:amount, :odate, :description, :category_id, :otype, :user_id)
  end
end
