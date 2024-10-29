# Problem Statement

This is an example solution for the problem statement at https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36

# To run the application

You can run the file against either the standard input or against any file(s) by providing the filename(s) as an argument:

```bash
./receipt_printer.rb examples/input1.txt
```

The application only uses core ruby functionality and was tested using MRI Ruby 3.3.5

# Tests

Please run the following for both integration tests and for the minitest suite. The latter uses `bundler` so you'll need to make sure to run `bundle install` before the first run as well.

```bash
./run_test.sh
```

# Notes

The example output of example 3 has been changed from containing `3 box` to `3 boxes` to align with the input, as inflection support was not part of the original problem statement, and external tools like Rail's inflection library are not supported
