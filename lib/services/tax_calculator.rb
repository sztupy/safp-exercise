# frozen_string_literal: true

# Calculates the tax values for a specific BasketItem given the appropriate categories.
# Returns a hash containing:
#   `item_tax_rate`: The tax rate used for the items
#   `item_tax`: The tax on a single item
#   `total_tax`: The total amount of tax (for multi-amount items)
#   `total_value`: The total amount to be paid for the item
class TaxCalculator
  def calculate(item, categories)
    item_tax_rate = (categories.include?(:exempt) ? 0 : 10) + (categories.include?(:imported) ? 5 : 0)
    item_tax_unrounded = (item.value / 100) * item_tax_rate
    item_tax = (item_tax_unrounded * 20).ceil.to_d / 20

    total_tax = item.amount * item_tax
    total_value = item.amount * (item.value + item_tax)

    { item_tax_rate:, item_tax:, total_tax:, total_value: }
  end
end
