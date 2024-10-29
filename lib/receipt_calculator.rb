# frozen_string_literal: true

require_relative 'models/basket_item'
require_relative 'services/categorizer'
require_relative 'services/tax_calculator'
require_relative 'services/basket_parser'

require 'bigdecimal/util'

# Parses a list of items (supporting both arrays and line-based IO) into a basket,
# then categorizes the items and calculates the tax on them.
#
# Returns the calculation results as a hash:
#   `basket_items`: The parsed items as an array of BasketItem
#   `receipt_items`: The items on the calculated receipt as a hash:
#      `amount`: The number of items
#      `description`: The description of the items
#      `total_tax`: The total amount of tax on the items
#      `total_value`: The total value of the items, including sales tax
#   `sales_tax`: The total value of sales tax of the items in the basket
#   `total`: The total value you need to pay - including taxes - for the items in the basket
class ReceiptCalculator
  attr_reader :receipt_items, :total, :sales_tax

  def initialize
    @categorizer = Categorizer.new
    @tax_calculator = TaxCalculator.new
    @basket_parser = BasketParser.new
  end

  def calculate(data)
    basket_items = parse_data(data)
    calculate_receipt(basket_items)
  end

  private

  def parse_data(data)
    basket_items = []

    data.each do |line|
      basket_items << @basket_parser.parse_line(line)
    rescue StandardError => e
      raise format("Could not parse line '%<line>s'. Error: '%<error>s'", line: line.strip, error: e)
    end

    basket_items
  end

  def calculate_receipt(basket_items)
    receipt_items = basket_items.map { |item| calculate_tax_for_item(item) }

    {
      basket_items:,
      receipt_items:,
      sales_tax: receipt_items.reduce(BigDecimal(0)) { |acc, item| acc + item[:total_tax] },
      total: receipt_items.reduce(BigDecimal(0)) { |acc, item| acc + item[:total_value] }
    }
  end

  def calculate_tax_for_item(item)
    categories = @categorizer.categorize(item)
    taxed_values = @tax_calculator.calculate(item, categories)

    {
      amount: item.amount,
      description: item.description,
      total_tax: taxed_values[:total_tax],
      total_value: taxed_values[:total_value]
    }
  end
end
