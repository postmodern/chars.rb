require 'set'

module Chars
  class CharSet < SortedSet

    #
    # Creates a new CharSet object.
    #
    # @param [Array<String, Integer, Range>] chars
    #   The chars for the CharSet.
    #
    def initialize(*chars)
      super()

      merge_chars = lambda { |element|
        if element.kind_of?(String)
          element.each_byte(&merge_chars)
        elsif element.kind_of?(Integer)
          self << element
        elsif element.kind_of?(Enumerable)
          element.each(&merge_chars)
        end
      }

      merge_chars.call(chars)
    end

    alias include_byte? include?
    alias bytes to_a
    alias each_byte each
    alias select_bytes select
    alias map_bytes map

    #
    # Determines if a character is contained within the character set.
    #
    # @param [String] char
    #   The character to search for.
    #
    # @return [Boolean]
    #   Specifies whether the character is contained within the
    #   character set.
    #
    def include_char?(char)
      return false unless char.respond_to?(:each_byte)

      char.each_byte do |b|
        return include?(b)
      end
    end

    #
    # The characters within the character set.
    #
    # @return [Array<String>]
    #   All the characters within the character set.
    #
    def chars
      map { |b| b.chr }
    end

    #
    # Iterates over every character within the character set.
    #
    # @yield [char]
    #   If a block is given, it will be passed each character in the
    #   character set.
    #
    # @yieldparam [String] char
    #   Each character in the character set.
    #
    def each_char(&block)
      each { |b| block.call(b.chr) } if block
    end

    #
    # Selects characters from the character set.
    #
    # @yield [char]
    #   If a block is given, it will be used to select the characters
    #   from the character set.
    #
    # @yieldparam [String] char
    #   The character to select or reject.
    #
    # @return [Array<String>]
    #   The selected characters from the character set.
    #
    def select_chars(&block)
      chars.select(&block)
    end

    #
    # Maps the characters of the character set.
    #
    # @yield [char]
    #   The given block will be used to transform the characters within
    #   the character set.
    #
    # @yieldparam [String] char
    #   Each character in the character set.
    #
    # @return [Array<String>]
    #   The mapped characters of the character set.
    #
    def map_chars(&block)
      chars.map(&block)
    end

    #
    # @return [Integer]
    #   A random byte from the character set.
    #
    def random_byte
      self.entries[rand(self.length)]
    end

    #
    # @return [String]
    #   A random char from the character set.
    #
    def random_char
      random_byte.chr
    end

    #
    # Pass random bytes to a given block.
    #
    # @param [Integer] n
    #   Specifies how many times to pass a random byte to the block.
    #
    # @yield [byte]
    #   The block will receive the random bytes.
    #
    # @yieldparam [Integer] byte
    #   The random byte from the character set.
    #
    # @return [Integer]
    #   The number of times the given block was passed random bytes.
    #
    def each_random_byte(n,&block)
      n.times { block.call(random_byte) }
    end

    #
    # Pass random characters to a given block.
    #
    # @param [Integer] n
    #   Specifies how many times to pass a random character to the block.
    #
    # @yield [char]
    #   The block will receive the random characters.
    #
    # @yieldparam [String] char
    #   The random character from the character set.
    #
    # @return [Integer]
    #   The number of times the given block was passed random characters.
    #
    def each_random_char(n,&block)
      each_random_byte(n) { |b| block.call(b.chr) }
    end

    #
    # Creates an Array of random bytes from the character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random bytes.
    #
    # @return [Array<Integer>]
    #   The randomly selected bytes.
    #
    def random_bytes(length)
      if (length.kind_of?(Array) || length.kind_of?(Range))
        return Array.new(length.sort_by { rand }.first) { random_byte }
      else
        return Array.new(length) { random_byte }
      end
    end

    #
    # Creates an Array of random non-repeating bytes from the character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random non-repeating bytes.
    #
    # @return [Array<Integer>]
    #   The randomly selected non-repeating bytes.
    #
    def random_distinct_bytes(length)
      if (length.kind_of?(Array) || length.kind_of?(Range))
        return self.entries.sort_by { rand }.slice(0...(length.sort_by { rand }.first))
      else
        return self.entries.sort_by { rand }.slice(0...length) 
      end
    end

    #
    # Creates an Array of random characters from the character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random characters.
    #
    # @return [Array<String>]
    #   The randomly selected characters.
    #
    def random_chars(length)
      random_bytes(length).map { |b| b.chr }
    end

    #
    # Creates a String containing randomly selected characters from the
    # character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the String of random characters.
    #
    # @return [String]
    #   The String of randomly selected characters.
    #
    # @see random_chars
    #
    def random_string(length)
      random_chars(length).join
    end

    #
    # Creates an Array of random non-repeating characters from the
    # character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random non-repeating characters.
    #
    # @return [Array<Integer>]
    #   The randomly selected non-repeating characters.
    #
    def random_distinct_chars(length)
      random_distinct_bytes(length).map { |b| b.chr }
    end

    #
    # Creates a String containing randomly selected non-repeating
    # characters from the character set.
    #
    # @param [Integer, Array, Range] length
    #   The length of the String of random non-repeating characters.
    #
    # @return [String]
    #   The String of randomly selected non-repeating characters.
    #
    # @see random_distinct_chars
    #
    def random_distinct_string(length)
      random_distinct_chars(length).join
    end


    #
    # Finds sub-strings within given data that are made of characters within
    # the character set.
    #
    # @param [String] data
    #   The data to find sub-strings within.
    #
    # @param [Hash] options
    #   Additional options.
    #
    # @option options [Integer] :length (4)
    #   The minimum length of sub-strings found within the given data.
    #
    # @option options [Boolean] :offsets (false)
    #   Specifies whether to return a Hash of offsets and matched
    #   sub-strings within the data, or to just return the matched
    #   sub-strings themselves.
    #
    def strings_in(data,options={})
      min_length = (options[:length] || 4)

      if options[:offsets]
        found = {}
        found_substring = lambda { |offset,substring|
          found[offset] = substring
        }
      else
        found = []
        found_substring = lambda { |offset,substring|
          found << substring
        }
      end

      return found if data.length < min_length

      index = 0

      while index <= (data.length - min_length)
        if self === data[index...(index + min_length)]
          sub_index = (index + min_length)

          while self.include_char?(data[sub_index..sub_index])
            sub_index += 1
          end

          found_substring.call(index,data[index...sub_index])
          index = sub_index
        else
          index += 1
        end
      end

      return found
    end

    #
    # Creates a new CharSet object by unioning the character set with
    # another character set.
    #
    # @param [CharSet, Array, Range] other_set
    #   The other character set to union with.
    #
    # @return [CharSet]
    #   The unioned character sets.
    #
    def |(other_set)
      super(CharSet.new(other_set))
    end

    alias + |

    #
    # Compares the bytes within a given string with the bytes of the
    # character set.
    #
    # @param [String] string
    #   The string to compare with the character set.
    #
    # @return [Boolean]
    #   Specifies whether all of the bytes within the given string are
    #   included in the character set.
    #
    # @example
    #   Chars.alpha === "hello"
    #   # => true
    #
    def ===(string)
      return false unless string.respond_to?(:each_byte)

      string.each_byte do |b|
        return false unless include?(b)
      end

      return true
    end

    alias =~ ===

    #
    # Inspects the character set.
    #
    # @return [String]
    #   The inspected character set.
    #
    def inspect
      "#<#{self.class.name}: {" + map { |b|
        case b
        when (0x07..0x0d), (0x20..0x7e)
          b.chr.dump
        when 0x00
          # sly hack to make char-sets more friendly
          # to us C programmers
          '"\0"'
        else
          "0x%02x" % b
        end
      }.join(', ') + "}>"
    end

  end
end
