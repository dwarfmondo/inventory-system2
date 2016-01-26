class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    load_product
  end

  def new
    @product = Product.new
  end

  def edit
    load_product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def update
    load_product

    if @product.update_attributes(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def take
    load_product

    @product.decrement!(:quantity)

    render text: @product.quantity
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :quantity)
  end
end
