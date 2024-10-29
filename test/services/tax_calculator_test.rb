# frozen_string_literal: true

require "minitest/autorun"
require_relative '../../lib/receipt_calculator'

describe TaxCalculator do
  def setup
    @it = TaxCalculator.new
  end

  describe "Rounding" do
    it "Rounds up tax value to nearest 0.05" do
      item = BasketItem.new(amount: 1, value: "9.95", description: "Item")

      result = @it.calculate(item, [])

      _(result[:item_tax]).must_equal "1.00".to_d
      _(result[:total_value]).must_equal "10.95".to_d
    end

    it "Rounds up each piece of item separately" do
      item = BasketItem.new(amount: 100, value: "9.95", description: "Item")

      result = @it.calculate(item, [])

      _(result[:item_tax]).must_equal "1.00".to_d
      _(result[:total_tax]).must_equal "100.00".to_d
      _(result[:total_value]).must_equal "1095.00".to_d
    end
  end

  describe "Tax amount" do
    before do
      @item = BasketItem.new(amount: 1, value: "10.00", description: "Item")
    end

    it "Adds 10% tax on standard items" do
      _(@it.calculate(@item, [])[:item_tax]).must_equal "1.00".to_d
    end

    it "Adds no tax on exempt items" do
      _(@it.calculate(@item, [:exempt])[:item_tax]).must_equal "0.00".to_d
    end

    it "Adds 15% tax on imported items" do
      _(@it.calculate(@item, [:imported])[:item_tax]).must_equal "1.50".to_d
    end

    it "Adds 5% tax on imported & exempt items" do
      _(@it.calculate(@item, [:imported, :exempt])[:item_tax]).must_equal "0.50".to_d
    end
  end
end
