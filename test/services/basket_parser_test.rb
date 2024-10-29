# frozen_string_literal: true

require "minitest/autorun"
require_relative '../../lib/receipt_calculator'

describe BasketParser do
  def setup
    @it = BasketParser.new
  end

  it "obtains the description, value and amount from a string" do
    result = @it.parse_line("5 various items at 1.23")

    _(result.amount).must_equal 5
    _(result.description).must_equal "various items"
    _(result.value).must_equal "1.23".to_d
  end

  it "throws an error in case the line is incorrect" do
    assert_raises { @it.parse_line("5 various items at five") }
    assert_raises { @it.parse_line("five various items at 1.23") }
    assert_raises { @it.parse_line("5 at 1.23") }
  end
end
