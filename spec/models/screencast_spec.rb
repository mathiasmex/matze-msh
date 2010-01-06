require File.dirname(__FILE__) + '/../spec_helper'

describe Screencast, "with fixtures loaded" do
  fixtures :screencasts, :products, :categories,
           :manufacturers, :formats, :photos
  before (:each) do
    @screencast = screencasts(:intro)
  end

  it "should be valid" do
    @screencast.should be_valid
  end

  it "should have a product not nil" do
    @screencast.product.should_not be_nil
  end

  it "should have a valid product" do
    @screencast.product.should be_valid
  end

  it "should have a valid category" do
    @screencast.product.category.name.should eql('Basics')
  end

  it "should not save a product with an existing name" do
    @new_screencast = Screencast.new
    @new_screencast.build_product
    @new_screencast.product.name = "Einf&uuml;hrung in BDD"
    @new_screencast.product.description = "Eine kurze Einf&uuml;hrung in BDD f&uuml;r Einsteiger."
    @new_screencast.product.price = 900 #cents
    @new_screencast.product.category = categories(:basics)
    @new_screencast.product.manufacturer = manufacturers(:rails_experts)
    @new_screencast.product.save.should be_false
    @new_screencast.product.errors.count.should > 0
    @new_screencast.product.errors.full_messages[0].should == "Name has already been taken"
  end
end

describe Screencast, "without fixtures" do
  fixtures:categories, :manufacturers
  before(:each) do
    @screencast = Screencast.new
    @screencast.build_product 
  end

  it "should not have valid a product without name, \ 
      description, price, category and manufacturer" do
    @screencast.product.should_not be_valid
    @screencast.product.name.should be_nil
    @screencast.product.description.should be_nil
    @screencast.product.price.should be_nil
    @screencast.product.category.should be_nil
    @screencast.product.manufacturer.should be_nil
  end

  it "should have valid product with given name, description, \
      price, category and manufacturer" do
      @screencast.product.name = "Einf&uuml;hrung in Rails"
      @screencast.product.description = "Eine kurze Einf&uuml;hrung \
                                         in BDD f&uuml;r Einsteiger."
      @screencast.product.price = 900 #cents
      @screencast.product.category = categories(:basics)
      @screencast.product.manufacturer = manufacturers(:rails_experts)
      @screencast.product.should be_valid
      @screencast.product.save.should be_true
  end
end

