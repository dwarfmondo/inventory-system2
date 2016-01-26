require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "index" do
    it "should display a list of @products" do
      product_1 = Product.create!(name: 'Product 1')
      product_2 = Product.create!(name: 'Product 2')

      get :index

      expect(assigns(:products)).to match_array([product_1, product_2])
    end
  end

  describe "new" do
    it "should render the new view" do
      product = Product.new

      get :new

      expect(response).to render_template("new")
    end
  end

  describe "create" do
    it "should save the product" do
      product = Product.new(name: 'Product 1')

      post :create, product: product.attributes

      expect(response).to redirect_to products_url
    end
  end

  describe "edit" do
    it "should display the edit view" do
      product = Product.create(name: 'Product 1')

      get :edit, id: product.id

      expect(assigns(:product)).to match(product)
      expect(response).to render_template("edit")
    end
  end

  describe "update" do
    it "should save changes to the product" do
      product = Product.create(name: 'Product 1')

      patch :update, { id: product.id, product: { quantity: 10 } }
      product.reload

      expect(assigns(:product).quantity).to eql(10)
      expect(response).to redirect_to product_path(product)
    end
  end

  describe "take" do
    it "should decrement the product quantity" do
      product = Product.create(name: 'Product 1', quantity: 10)

      post :take, id: product.id
      product.reload

      expect(assigns(:product).quantity).to eql(9)
      expect(response.body).to eql('9')
    end
  end
end
