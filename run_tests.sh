#!/usr/bin/env bash

set -e

echo "Running integration checks"

./receipt_printer.rb examples/input1.txt 2>&1 | diff - examples/output1.txt
./receipt_printer.rb examples/input2.txt 2>&1 | diff - examples/output2.txt
./receipt_printer.rb examples/input3.txt 2>&1 | diff - examples/output3.txt
./receipt_printer.rb examples/input_invalid.txt 2>&1 | diff - examples/output_invalid.txt

echo "Integration checks passed"

echo "Running unit test suite"

bundle exec rake test
