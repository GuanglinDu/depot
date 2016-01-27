require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  test "The total price of a single book should be euqal to its price" do
    assert_equal line_items(:one).total_price, products(:C).price,
      "Should be euqal"
  end

  test "The total price of 2 books should be euqal to their sum" do
    line_items(:two).quantity = 2
    assert_equal line_items(:two).total_price, 2.0 * products(:Cpp).price,
      "Should be euqal"
  end
end
