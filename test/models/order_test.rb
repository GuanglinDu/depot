require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = Order.create
    @order_dave = orders(:dave)
    @order_erica = orders(:erica)
    @order_cameron = orders(:cameron)
 
    @cart = Cart.create
    @book_one = products(:ruby)
    @book_two = products(:two)
  end

  test "order attributes must not be empty" do
    assert @order.invalid?
    assert @order.errors[:name].any?
    assert @order.errors[:address].any?
    assert @order.errors[:email].any?
    
    assert @order_dave.valid?
    assert_equal 0, @order_dave.errors[:name].count 
    assert_equal 0, @order_dave.errors[:address].count 
    assert_equal 0, @order_dave.errors[:email].count
  end

  test "pay types must be included" do
    assert_not_includes Order::PAYMENT_TYPES, @order.pay_type
    assert_includes Order::PAYMENT_TYPES, @order_dave.pay_type
    assert_includes Order::PAYMENT_TYPES, @order_erica.pay_type
    assert_includes Order::PAYMENT_TYPES, @order_cameron.pay_type
  end

  test "must have ordered 0 items" do
    @order_dave.add_line_items_from_cart(@cart)
    assert_equal 0, @order_dave.line_items.count,
      "Dave must have ordered 0 item" 
  end

  test "must have ordered 2 items" do 
    @cart.add_product(@book_one.id).save!
    @cart.add_product(@book_two.id).save!
    @order_erica.add_line_items_from_cart(@cart)
    assert_equal 2, @order_erica.line_items.count,
      "Erica must have ordered 2 items" 
  end
end
