#!/usr/bin/env bash

./main.rb examples/input1.txt | diff - examples/output1.txt
./main.rb examples/input2.txt | diff - examples/output2.txt
./main.rb examples/input3.txt | diff - examples/output3.txt
./main.rb examples/input_invalid.txt 2>&1 | diff - examples/output_invalid.txt
