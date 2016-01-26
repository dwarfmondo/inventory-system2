require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validate' do
    it 'should make name required' do
      product = Product.new
      expect(product).not_to be_valid
      expect(product.errors.keys).to include(:name)
    end
  end
end
