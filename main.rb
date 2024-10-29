#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bigdecimal/util'

items = []

EXEMPT = [/\Abook(s)?\Z/, /\Achocolate bar(s)?\Z/, /\Abox(es)? of chocolate(s)?\Z/, /\Apacket(s)? of headache pills\Z/]

ARGF.each_line do |line|
  if line.strip =~ /\A(\d+) (.*) at ([0-9.]+)\Z/
    amount = $1.to_i
    description = $2
    value = $3.to_d

    imported = description.start_with?("imported ")

    name = description.delete_prefix("imported ")
    exempt = EXEMPT.any?{|e| name =~ e}

    if amount<=0 || value <=0
      STDERR.puts "Amounts and values should be positive"
    else
      items << {
        amount: amount,
        description: description,
        value: value,
        imported: imported,
        exempt: exempt
      }
    end
  else
    STDERR.puts "Could not process line: '#{line.strip}'"
  end
end

sales_tax = 0.to_d
total = 0.to_d

items.each do |item|
  item_tax_rate = (item[:exempt] ? 0 : 10) + (item[:imported] ? 5 : 0)
  item_tax_unrounded = ((item[:value] / 100) * item_tax_rate)
  item_tax = ((item_tax_unrounded * 20).ceil.to_d) / 20

  total_tax = item[:amount] * item_tax
  shelf_value = item[:value] + item_tax
  total_value = item[:amount] * shelf_value

  sales_tax += total_tax
  total += total_value

  puts "%d %s: %0.2f" % [item[:amount], item[:description], total_value]
end

puts "Sales Taxes: %0.2f" % [sales_tax]
puts "Total: %0.2f" % [total]
