require_relative 'item'

class Cart
  INPUT_REGEX = /\d+\s(\D+)\sat\s(\d+\.\d{1,2})\s*/

  attr_accessor :items

  def initialize(input)
    self.items = input.scan(INPUT_REGEX).map do |description, price|
      Item.new(description, price.to_f)
    end
  end

  def receipt
    taxes_string = 'Sales Taxes: ' + '%.2f' % items.map(&:sales_taxes).sum
    total_string = 'Total: ' + '%.2f' % items.map(&:total_price).sum
    [items, taxes_string, total_string].flatten.join(' ')
  end
end
