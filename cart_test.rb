require 'minitest/autorun'
require_relative 'cart'

class CartTest < Minitest::Test
  def test_input_regex
    refute_match Cart::INPUT_REGEX, ''
    refute_match Cart::INPUT_REGEX, 'foo'
    refute_match Cart::INPUT_REGEX, '1 foo for 0.99'

    assert_match Cart::INPUT_REGEX, '1 foo at 0.99'
    assert_match Cart::INPUT_REGEX, '1 foo at 0.99 1 bar at 1.99'
    assert_match Cart::INPUT_REGEX, '1 foo at 0.99 1 bar at 1.99 1 baz at 2.99'
    assert_match Cart::INPUT_REGEX, '1 foo at 0.99 1 bar at 1.99 1 baz at 2.99 1 qux at 3.99'
  end

  # Use the input that was provided with the problem definition to validate the output format…

  def test_receipt_one
    input = '1 book at 12.49 1 music CD at 14.99 1 chocolate bar at 0.85'
    expected = '1 book: 12.49 1 music CD: 16.49 1 chocolate bar: 0.85 Sales Taxes: 1.50 Total: 29.83'
    assert_equal expected, Cart.new(input).receipt
  end

  def test_receipt_two
    input = '1 imported box of chocolates at 10.00 1 imported bottle of perfume at 47.50'
    expected = '1 imported box of chocolates: 10.50 1 imported bottle of perfume: 54.65 Sales Taxes: 7.65 Total: 65.15'
    assert_equal expected, Cart.new(input).receipt
  end

  def test_receipt_three
    input = '1 imported bottle of perfume at 27.99 1 bottle of perfume at 18.99 1 packet of headache pills at 9.75 1 box of imported chocolates at 11.25'
    expected = '1 imported bottle of perfume: 32.19 1 bottle of perfume: 20.89 1 packet of headache pills: 9.75 1 box of imported chocolates: 11.85 Sales Taxes: 6.70 Total: 74.68'
    assert_equal expected, Cart.new(input).receipt
  end
end
