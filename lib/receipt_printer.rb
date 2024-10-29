# frozen_string_literal: true

require_relative "models/basket_item"
require_relative "services/categorizer"
require_relative "services/tax_calculator"
require_relative "services/receipt_parser"

require 'bigdecimal/util'

class ReceiptPrinter
  def initialize
    @basket_items = []
    @categorizer = Categorizer.new
    @tax_calculator = TaxCalculator.new
    @receipt_parser = ReceiptParser.new
  end

  def calculate!
    @sales_tax = BigDecimal(0)
    @total = BigDecimal(0)
    @receipt_items = []

    @basket_items.each do |item|
      categories = @categorizer.categorize(item)
      taxed_values = @tax_calculator.calculate(item, categories)

      @sales_tax += taxed_values[:total_tax]
      @total += taxed_values[:total_value]

      @receipt_items << {amount: item.amount, description: item.description, total_value: taxed_values[:total_value]}
    end
  end

  def run(data)
    data.each do |line|
      @basket_items << @receipt_parser.parse_line(line)
    rescue => error
      STDERR.puts "Could not parse line '%s'. Error: '%s'" % [line.strip, error]
    end

    calculate!

    @receipt_items.each do |item|
      puts "%d %s: %0.2f" % [item[:amount], item[:description], item[:total_value]]
    end

    puts "Sales Taxes: %0.2f" % [@sales_tax]
    puts "Total: %0.2f" % [@total]
  end
end
