# frozen_string_literal: true

require "minitest/autorun"
require_relative '../../lib/receipt_calculator'

describe Categorizer do
  def setup
    @it = Categorizer.new

    @standard_item = BasketItem.new(amount: 1, value: 1, description: "CD")
    @exempt_item = BasketItem.new(amount: 1, value: 1, description: "book")
    @imported_item = BasketItem.new(amount: 1, value: 1, description: "imported CD")
    @imported_exempt_item = BasketItem.new(amount: 1, value: 1, description: "imported book")
  end

  it "returns an empty array for standard items" do
    _(@it.categorize(@standard_item)).must_equal []
  end

  it "can categorize exempt items" do
    _(@it.categorize(@exempt_item)).must_equal [:exempt]
    _(@it.categorize(@imported_exempt_item)).must_include :exempt
  end

  it "can categorize imported items" do
    _(@it.categorize(@imported_item)).must_equal [:imported]
    _(@it.categorize(@imported_exempt_item)).must_include :imported
  end
end
