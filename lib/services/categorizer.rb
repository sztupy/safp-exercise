# frozen_string_literal: true

# Categorizes a specific BasketItem for tax purposes
# Returns an array with the categories which can either be `:imported`, `:exempt` or both
class Categorizer
  EXEMPT_LIST = [/\Abook(s)?\Z/, /\Achocolate bar(s)?\Z/, /\Abox(es)? of chocolate(s)?\Z/,
                 /\Apacket(s)? of headache pills\Z/].freeze
  IMPORTED_PREFIX = 'imported '

  def categorize(item)
    categories = []
    name = item.description.dup

    if name.start_with?(IMPORTED_PREFIX)
      categories << :imported
      name.delete_prefix!(IMPORTED_PREFIX)
    end

    categories << :exempt if EXEMPT_LIST.any? { |exempt_checker| name.match(exempt_checker) }

    categories
  end
end
