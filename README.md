# Problem Statement

This is an example solution for the problem statement at https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36

# To run the application

You can run the file against either the standard input or against any file(s) by providing the filename(s) as an argument:

```bash
./receipt_printer.rb examples/input1.txt
```

If multiple files are provided they are concatenated together before running the app.

The application only uses core ruby functionality and was tested using MRI Ruby 3.3.5. GitHub CI also verified the application for 3.1 and above, including 3.4-preview (for that please see notes below)

# Tests

You can run the following command for both integration tests and for the minitest suite. The latter uses `bundler` so you'll need to make sure to run `bundle install` before the first run as well.

```bash
./run_test.sh
```

# Notes

* The application uses `BigDecimal` to store monetary amounts. While this class is currently part of core ruby, it will be made as a standalone gem from version `3.4`. In a strict no-library situation and to avoid potential issues that can arise from using floats, from Ruby 3.4 alternatives for `BigDecimal` would be using the fractional representation where monetary amounts are always stored as the smallest sub-unit in plain integer, like cents. If libraries are allowed `ruby-money` is usually a good choice to handle monetary amounts.
* The example output of example #3 has been changed from containing `3 box` to `3 boxes` to make sure it aligns with the input, as inflection support was not part of the original problem statement, and external tools like Rails' inflection library are not supported
* It is assumed that the amount of items in a basket is always an integer, e.g. there is no such thing as `1.5 kgs of chocolate`. Adding support for these would require clarification on the rounding mechanism, as currently rounding is on a per-unit basis.
* The `Categorizer` only supports the items mentioned in the example (books, chocolates and headache pills) and even then is fairly strict on the allowed input. In a real-world case that class would likely reach out to a database, an external API or obtain the exemption details from a more complete list of configuration to know their tax exempt statuses.
