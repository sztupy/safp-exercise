#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/receipt_calculator'

begin
  calculator = ReceiptCalculator.new
  results = calculator.calculate(ARGF)

  results[:receipt_items].each do |item|
    puts format('%<amount>d %<description>s: %<value>0.2f', amount: item[:amount], description: item[:description],
                                                            value: item[:total_value])
  end

  puts format('Sales Taxes: %0.2f', results[:sales_tax])
  puts format('Total: %0.2f', results[:total])
rescue StandardError => e
  warn "Could not calculate receipt: '#{e}'"
  exit(1)
end
