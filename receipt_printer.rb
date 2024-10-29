#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/receipt_calculator'

begin
  calculator = ReceiptCalculator.new
  results = calculator.calculate(ARGF)

  results[:receipt_items].each do |item|
    puts "%d %s: %0.2f" % [item[:amount], item[:description], item[:total_value]]
  end

  puts "Sales Taxes: %0.2f" % [results[:sales_tax]]
  puts "Total: %0.2f" % [results[:total]]
rescue => error
  STDERR.puts "Could not calculate receipt: '#{error}'"
  exit(1)
end
