class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  def index
    @products = Product.all
  end
  
  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to @product, notice: "Product was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." 
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:photo, :name, :description, :stock, :price, :category_id)
    end
end