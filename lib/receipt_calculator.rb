# frozen_string_literal: true

require_relative "models/basket_item"
require_relative "services/categorizer"
require_relative "services/tax_calculator"
require_relative "services/basket_parser"

require 'bigdecimal/util'

class ReceiptCalculator
  attr_reader :receipt_items, :total, :sales_tax

  def initialize
    @categorizer = Categorizer.new
    @tax_calculator = TaxCalculator.new
    @basket_parser = BasketParser.new
  end

  def calculate(data)
    basket_items = []

    data.each do |line|
      basket_items << @basket_parser.parse_line(line)
    rescue => error
      raise "Could not parse line '%s'. Error: '%s'" % [line.strip, error]
    end

    sales_tax = BigDecimal(0)
    total = BigDecimal(0)
    receipt_items = []

    basket_items.each do |item|
      categories = @categorizer.categorize(item)
      taxed_values = @tax_calculator.calculate(item, categories)

      sales_tax += taxed_values[:total_tax]
      total += taxed_values[:total_value]

      receipt_items << {amount: item.amount, description: item.description, total_value: taxed_values[:total_value]}
    end

    {
      basket_items: ,
      receipt_items: ,
      sales_tax: ,
      total:
    }
  end
end
