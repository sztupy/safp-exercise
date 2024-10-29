# frozen_string_literal: true

require "minitest/autorun"
require_relative '../lib/receipt_calculator'

describe ReceiptCalculator do
  def setup
    @it = ReceiptCalculator.new
  end

  describe "Examples" do
    it "Passes example #1" do
      results = @it.calculate([
        "2 book at 12.49",
        "1 music CD at 14.99",
        "1 chocolate bar at 0.85"
      ])

      _(results[:receipt_items][0][:total_value]).must_equal 24.98
      _(results[:receipt_items][1][:total_value]).must_equal 16.49
      _(results[:receipt_items][2][:total_value]).must_equal 0.85
      _(results[:sales_tax]).must_equal 1.50
      _(results[:total]).must_equal 42.32
    end

    it "Passes example #2" do
      results = @it.calculate([
        "1 imported box of chocolates at 10.00",
        "1 imported bottle of perfume at 47.50"
      ])

      _(results[:receipt_items][0][:total_value]).must_equal 10.50
      _(results[:receipt_items][1][:total_value]).must_equal 54.65
      _(results[:sales_tax]).must_equal 7.65
      _(results[:total]).must_equal 65.15
    end

    it "Passes example #3" do
      results = @it.calculate([
        "1 imported bottle of perfume at 27.99",
        "1 bottle of perfume at 18.99",
        "1 packet of headache pills at 9.75",
        "3 imported boxes of chocolates at 11.25"
      ])

      _(results[:receipt_items][0][:total_value]).must_equal 32.19
      _(results[:receipt_items][1][:total_value]).must_equal 20.89
      _(results[:receipt_items][2][:total_value]).must_equal 9.75
      _(results[:receipt_items][3][:total_value]).must_equal 35.55
      _(results[:sales_tax]).must_equal 7.90
      _(results[:total]).must_equal 98.38
    end
  end
end
