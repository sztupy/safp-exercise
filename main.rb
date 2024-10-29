#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/receipt_printer'

app = ReceiptPrinter.new
app.run(ARGF)
