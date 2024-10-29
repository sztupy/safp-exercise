# frozen_string_literal: true

class TaxCalculator
  def calculate(item, categories)
    item_tax_rate = (categories.include?(:exempt) ? 0 : 10) + (categories.include?(:imported) ? 5 : 0)
    item_tax_unrounded = (item.value / 100) * item_tax_rate
    item_tax = ((item_tax_unrounded * 20).ceil).to_d / 20

    total_tax = item.amount * item_tax
    shelf_value = item.value + item_tax
    total_value = item.amount * shelf_value

    {
      item_tax_rate:,
      item_tax:,
      total_tax:,
      shelf_value:,
      total_value:
    }
  end
end
