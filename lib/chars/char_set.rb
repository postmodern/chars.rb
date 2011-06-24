require 'set'

module Chars
  class CharSet < SortedSet

    #
    # Creates a new CharSet object.
    #
    # @param [Array<String, Integer, Enumerable>] arguments
    #   The chars for the CharSet.
    #
    # @raise [TypeError]
    #   One of the arguments was not a {String}, {Integer} or `Enumerable`.
    #
    def initialize(*arguments)
      super()

      @chars = Hash.new { |hash,key| hash[key] = byte_to_char(key) }

      arguments.each do |subset|
        case subset
        when String, Integer
          self << subset
        when Enumerable
          subset.each { |char| self << char }
        else
          raise(TypeError,"arguments must be a String, Integer or Enumerable")
        end
      end
    end
    
    #
    # Creates a new character set.
    #
    # @see #initialize
    #
    # @since 0.2.1
    #
    def self.[](*arguments)
      new(*arguments)
    end

    #
    # Adds a character to the set.
    #
    # @param [String, Integer] other
    #   The character(s) or byte to add.
    #
    # @return [CharSet]
    #   The modified character set.
    #
    # @raise [TypeError]
    #   The argument was not a {String} or {Integer}.
    #
    # @since 0.2.1
    #
    def <<(other)
      case other
      when String
        other.each_char do |char|
          byte = char_to_byte(char)

          @chars[byte] = char
          super(byte)
        end

        return self
      when Integer
        super(other)
      else
        raise(TypeError,"can only append Strings and Integers")
      end
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
      unless char.empty?
        @chars.has_value?(char) || include_byte?(char_to_byte(char))
      else
        false
      end
    end

    #
    # The characters within the character set.
    #
    # @return [Array<String>]
    #   All the characters within the character set.
    #
    def chars
      map { |byte| @chars[byte] }
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
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_char
      return enum_for(:each_char) unless block_given?

      each { |byte| yield @chars[byte] }
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
      each_char.select(&block)
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
      each_char.map(&block)
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
      @chars[random_byte]
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
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_random_byte(n,&block)
      return enum_for(:each_random_byte,n) unless block_given?

      n.times { yield random_byte }
      return nil
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
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_random_char(n,&block)
      return enum_for(:each_random_char,n) unless block_given?

      each_random_byte(n) { |byte| yield @chars[byte] }
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
        Array.new(length.sort_by { rand }.first) { random_byte }
      else
        Array.new(length) { random_byte }
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
        self.entries.sort_by { rand }.slice(0...(length.sort_by { rand }.first))
      else
        self.entries.sort_by { rand }.slice(0...length) 
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
      random_bytes(length).map { |byte| @chars[byte] }
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
      random_distinct_bytes(length).map { |byte| @chars[byte] }
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
      min_length = options.fetch(:length,4)

      return found if data.length < min_length

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

      index = 0

      while index <= (data.length - min_length)
        if self === data[index,min_length]
          sub_index = (index + min_length)

          while self.include_char?(data[sub_index,1])
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
    # @param [CharSet, Array, Range] set
    #   The other character set to union with.
    #
    # @return [CharSet]
    #   The unioned character sets.
    #
    def |(set)
      set = CharSet.new(set) unless set.kind_of?(CharSet)

      return super(set)
    end

    alias + |

    #
    # Compares the bytes within a given string with the bytes of the
    # character set.
    #
    # @param [String, Enumerable] string
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
    def ===(other)
      case other
      when String
        other.each_char.all? { |char| include_char?(char) }
      when Enumerable
        other.all? do |element|
          case element
          when String
            include_char?(element)
          when Integer
            include_byte?(element)
          end
        end
      else
        false
      end
    end

    alias =~ ===

    #
    # Inspects the character set.
    #
    # @return [String]
    #   The inspected character set.
    #
    def inspect
      "#<#{self.class.name}: {" + map { |byte|
        case byte
        when (0x07..0x0d), (0x20..0x7e)
          @chars[byte].dump
        when 0x00
          # sly hack to make char-sets more friendly
          # to us C programmers
          '"\0"'
        else
          "0x%02x" % byte
        end
      }.join(', ') + "}>"
    end

    protected

    if RUBY_VERSION > '1.9.'
      #
      # Converts a byte to a character.
      #
      # @param [Integer] byte
      #   The byte to convert.
      #
      # @return [String]
      #   The character.
      #
      # @since 0.2.1
      #
      def byte_to_char(byte)
        byte.chr(Encoding::UTF_8)
      end

      #
      # Converts a character to a byte.
      #
      # @param [String] char
      #   The character to convert.
      #
      # @return [Integer]
      #   The byte.
      #
      # @since 0.2.1
      #
      def char_to_byte(char)
        char.ord
      end
    else
      #
      # Converts a byte to a character.
      #
      # @param [Integer] byte
      #   The byte to convert.
      #
      # @return [String]
      #   The character.
      #
      # @since 0.2.1
      #
      def byte_to_char(byte)
        byte.chr
      end

      #
      # Converts a character to a byte.
      #
      # @param [String] char
      #   The character to convert.
      #
      # @return [Integer]
      #   The byte.
      #
      # @since 0.2.1
      #
      def char_to_byte(char)
        char[0]
      end
    end

  end
end
