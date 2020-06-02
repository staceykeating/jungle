require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
   it 'should create a product with all fields present' do
    @category = Category.new(name: "Test Cat")
    @product = Product.new(name: "New New", price_cents: 6000, quantity: 13, :category => @category)
    @product.save
    expect(@product).to be_persisted
  end
  it 'should have a price' do
    @category = Category.new(name: "Test Cat")
    @product = Product.new(name: nil, price_cents: nil, quantity: 13, :category => @category)
    expect(@product).to_not (be_valid)
  end
  it 'should have a quantity' do
    @category = Category.new(name: "Test Cat")
    @product = Product.new(name: "New New", price_cents: 6000, quantity: nil, :category => @category)
    expect(@product).to_not (be_valid)
  end
  it 'should have a category' do
    @category = Category.new(name: "Test Cat")
    @product = Product.new(name: "New New", price_cents: 6000, quantity: 13, :category => nil)
    expect(@product).to_not (be_valid)
  end
end
end
