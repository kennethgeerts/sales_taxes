class Item
  def initialize(description, price)
    @description = description
    @price = price
  end

  def total_price
    price + sales_taxes
  end

  def sales_taxes
    round(basic_tax + import_tax)
  end

  def basic_tax
    exempt? ? 0 : 0.1 * price
  end

  def import_tax
    imported? ? 0.05 * price : 0
  end

  def to_s
    "1 #{description}: #{'%.2f' % total_price}"
  end

  private

  attr_reader :description, :price

  EXEMPTS = %w[
    book
    chocolate
    pill
  ].map { Regexp.new(_1, Regexp::IGNORECASE) }

  def exempt?
    EXEMPTS.any? { description.match?(_1) }
  end

  def imported?
    description.match?(/imported/i)
  end

  def round(amount)
    (amount / 0.05).ceil * 0.05
  end
end
