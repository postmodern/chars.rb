module Chars
  #
  # Enumerates through every possible string belonging to a character set and
  # of a given length.
  #
  # @api private
  #
  # @since 0.3.0
  #
  class StringEnumerator

    include Enumerable

    # The character set to generate the strings from.
    #
    # @return [CharSet]
    attr_reader :char_set

    # The desired length of each string.
    #
    # @return [Integer]
    attr_reader :length

    #
    # Initializes the string enumerator.
    #
    # @param [Chars::CharSet] char_set
    #   The character set to generate the strings from.
    #
    # @param [Integer] length
    #   The desired length of each string.
    #
    def initialize(char_set,length)
      @char_set = char_set
      @length   = length
    end

    #
    # Enumerates through every possible string belonging to {#char_set} and 
    # {#length} long.
    #
    # @yield [string]
    #   The given block will be passed each sequential string.
    #
    # @yieldparam [String] string
    #   A string belonging to {#char_set} and {#length} long.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator will be returned.
    #
    def each
      return enum_for(__method__) unless block_given?

      if @char_set.empty?
        return
      elsif @length == 0
        yield ""
        return
      end

      chars      = char_set.chars
      first_char = chars.first
      last_char  = chars.last

      next_char = {}

      chars.each_cons(2) do |c1,c2|
        next_char[c1] = c2
      end

      string = String.new(first_char * @length)

      last_index = @length - 1

      loop do
        chars.each do |c|
          string[last_index] = c

          yield string.dup
        end

        last_index.downto(0) do |i|
          if string[i] == last_char
            string[i] = first_char

            if i == 0
              return
            end
          else
            string[i] = next_char[string[i]]
            break
          end
        end
      end
    end

  end
end
