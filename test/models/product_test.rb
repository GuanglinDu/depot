require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], 
                 product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "My Book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy", 
                          price: 1, 
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
                          description: "yyy", 
                          price: 1, 
                          image_url: "fred.gif")
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:title]
  end

  # Uses send() to test a private method. See http://goo.gl/hFtmn8.
  test "should not be referenced by any line item" do
     assert (products(:ruby).send :ensure_not_referenced_by_any_line_item),
            "Should be true"
     assert (products(:ruby).send :ensure_not_referenced_by_any_line_item),
            "Should be true"
  end

  test "should be referenced by line items" do
     assert_not (products(:C).send :ensure_not_referenced_by_any_line_item),
                "Should be false"
     assert_not (products(:Cpp).send :ensure_not_referenced_by_any_line_item),
                "Should be false"
  end

  test "should be the last updated product" do
    products(:ruby).price *= 2.0
    products(:ruby).save!
    assert_equal products(:ruby).price,
                Product.latest.price,
                "Should be the same price"
  end
end
