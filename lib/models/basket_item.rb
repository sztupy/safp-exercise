# frozen_string_literal: true

# Describes a specific set of items in your basket you wish to calculate the tax on
#   `amount`: The amount you have of the specific item in your basket
#   `value`: The value (without tax) of the item
#   `description`: The name of the item, including whether it is imported
class BasketItem
  attr_reader :amount, :value, :description

  def initialize(amount:, value:, description:)
    raise 'Invalid amount' if amount.to_i <= 0
    raise 'Invalid value' if value.to_d <= 0

    @amount = amount.to_i
    @value = value.to_d
    @description = description.freeze
  end
end
