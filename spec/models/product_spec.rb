require 'rails_helper'

RSpec.describe Product, type: :model do
  
  
  describe 'Validations' do
    it "should be valid with all product fields" do
      category = Category.new(:name => "Fashion")
      product = Product.new(
        :name => "chair",
        :quantity => 5, 
        :price => 10,
        :category => category
        
      )
      product.save
      expect(product.errors.full_messages[0]).to be_nil
    end
    
    it "given no product name returns 'Name can't be blank'"do
      category = Category.new(:name => "Fashion")
      product = Product.new(
        
        :category => category, 
        :quantity => 5,
        :price => 10
      )
      product.save
      expect(product.errors.full_messages[0]).to eql("Name can't be blank")
    end
  
    it "should not be valid without product price" do
      category = Category.new(:name => "Fashion")
      product = Product.new(
        :name => "chair",
        :category => category, 
        :quantity => 5
        
      )
      product.save
      expect(product.errors.full_messages[0]).to be_present
    end

    it "should not be valid without product quantity" do
      category = Category.new(:name => "Fashion")
      product = Product.new(
        :name => "chair",
        :category => category, 
        :price => 10
        
      )
      product.save
      expect(product.errors.full_messages[0]).to be_present
    end

    it "should not be valid without product category" do
      category = Category.new(:name => "Fashion")
      product = Product.new(
        :name => "chair",
        :quantity => 5, 
        :price => 10
        
      )
      product.save
      expect(product.errors.full_messages[0]).to be_present
    end

  end

end
