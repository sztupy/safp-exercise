# frozen_string_literal: true

class BasketItem
  attr_reader :amount, :value, :description

  def initialize(amount: , value: , description: )
    raise "Invalid amount" if amount.to_i <= 0
    raise "Invalid value" if value.to_d <= 0

    @amount = amount.to_i
    @value = value.to_d
    @description = description.freeze
  end
end
