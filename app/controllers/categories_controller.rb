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
        redirect_to category_url(@category), notice: t('categories.notice.create')
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
      if @category.update(category_params)
        redirect_to category_url(@category), notice: t('categories.notice.update')
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
      if Operation.cat_destroy(@category.id) == 0 
        @category.destroy
        redirect_to categories_url, notice: t('categories.notice.destroy')
      else
        redirect_to category_url(@category), 
          alert: t('categories.alert.destroy'), status: :unprocessable_entity
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
