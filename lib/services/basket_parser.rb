# frozen_string_literal: true

# Parses a line of string and returns a BasketItem for further processing
class BasketParser
  def parse_line(line)
    match_data = line.strip.match(/\A(\d+) (.*) at ([0-9.]+)\Z/)
    raise 'Could not process line' unless match_data

    amount = match_data[1].to_i
    description = match_data[2]
    value = match_data[3].to_d

    BasketItem.new(amount:, value:, description:)
  end
end
