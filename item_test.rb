require 'minitest/autorun'
require_relative 'item'

class ItemTest < Minitest::Test
  def test_rounding_up_to_nearest_5_cents
    dummy_item = Item.new(nil, nil)
    assert_amount 6.35, dummy_item.send(:round, 6.31)
    assert_amount 6.35, dummy_item.send(:round, 6.34)
    assert_amount 6.35, dummy_item.send(:round, 6.35)
    assert_amount 6.40, dummy_item.send(:round, 6.36)
    assert_amount 6.40, dummy_item.send(:round, 6.39)
    assert_amount 6.40, dummy_item.send(:round, 6.40)
  end

  def test_basic_tax_for_taxable_items
    assert_amount 1.5, Item.new('Box of Cohiba cigars', 15.00).basic_tax
  end

  def test_basic_tax_for_non_taxable_items
    assert_amount 0, Item.new("Children's Book", 12.99).basic_tax
  end

  def test_import_tax_for_imported_items
    assert_amount 19.95, Item.new('Imported Playstation IV', 399).import_tax
  end

  def test_import_tax_for_non_imported_items
    assert_amount 0, Item.new('Original Walkman', 399).import_tax
  end

  def test_sales_taxes
    # We'll test a few combinations here, as the calculation is covered above
    assert_amount 1.5, Item.new('Box of Cohiba cigars', 15.00).sales_taxes
    assert_amount 0, Item.new("Children's Book", 12.99).sales_taxes
    assert_amount 2.25, Item.new('Imported Box of Cohiba cigars', 15.00).sales_taxes
    assert_amount 0.65, Item.new("Imported Children's Book", 12.99).sales_taxes
  end

  def test_total_price
    assert_amount 17.25, Item.new('Imported Box of Cohiba cigars', 15.00).total_price
  end

  def test_to_s
    expected = '1 Imported Box of Cohiba cigars: 17.25'
    assert_equal expected , Item.new('Imported Box of Cohiba cigars', 15.00).to_s
  end

  private

  def assert_amount(expected, actual)
    assert_in_delta expected, actual, 0.01
  end
end
