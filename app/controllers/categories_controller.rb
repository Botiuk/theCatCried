class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.list_order.page(params[:page])
  end

  def show
  end

  def new
    @category = Category.new(:ctype => params[:ctype])
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Категорія успішно створена" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Категорія успішно оновлена" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if Operation.cat_destroy(@category.id) == 0 
        @category.destroy
        format.html { redirect_to categories_url, notice: "Категорія успішно видалена" }
      else
        format.html { redirect_to category_url(@category), 
          alert: "Неможливо видалити! Є операції з даною категорією", status: :unprocessable_entity }
      end
    end
  end

  private
  
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :ctype)
    end
    
end
