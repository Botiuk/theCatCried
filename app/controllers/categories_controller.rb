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
      if @category.save
        redirect_to category_url(@category), notice: "Категорія успішно створена"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      if @category.update(category_params)
        redirect_to category_url(@category), notice: "Категорія успішно оновлена"
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
      if Operation.cat_destroy(@category.id) == 0 
        @category.destroy
        redirect_to categories_url, notice: "Категорія успішно видалена"
      else
        redirect_to category_url(@category), 
          alert: "Неможливо видалити! Є операції з даною категорією", status: :unprocessable_entity
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
