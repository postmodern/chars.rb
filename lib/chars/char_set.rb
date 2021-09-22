require 'set'

module Chars
  class CharSet < Set

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

      @chars = Hash.new { |hash,key| hash[key] = key.chr(Encoding::UTF_8) }

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
    # Initializes the copy of another {CharSet} object.
    #
    # @param [CharSet] other
    #   The other {CharSet} object.
    #
    def initialize_copy(other)
      @chars = other.instance_variable_get('@chars').dup
    end

    #
    # Creates a new {CharSet}.
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
          byte = char.ord

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
    # Determines if a character is contained within the {CharSet}.
    #
    # @param [String] char
    #   The character to search for.
    #
    # @return [Boolean]
    #   Specifies whether the character is contained within the
    #   {CharSet}.
    #
    def include_char?(char)
      unless char.empty?
        @chars.has_value?(char) || include_byte?(char.ord)
      else
        false
      end
    end

    #
    # The characters within the {CharSet}.
    #
    # @return [Array<String>]
    #   All the characters within the {CharSet}.
    #
    def chars
      map { |byte| @chars[byte] }
    end

    #
    # Iterates over every character within the {CharSet}.
    #
    # @yield [char]
    #   If a block is given, it will be passed each character in the
    #   {CharSet}.
    #
    # @yieldparam [String] char
    #   Each character in the {CharSet}.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_char
      return enum_for(__method__) unless block_given?

      each { |byte| yield @chars[byte] }
    end

    #
    # Selects characters from the {CharSet}.
    #
    # @yield [char]
    #   If a block is given, it will be used to select the characters
    #   from the {CharSet}.
    #
    # @yieldparam [String] char
    #   The character to select or reject.
    #
    # @return [Array<String>]
    #   The selected characters from the {CharSet}.
    #
    def select_chars(&block)
      each_char.select(&block)
    end

    #
    # Maps the characters of the {CharSet}.
    #
    # @yield [char]
    #   The given block will be used to transform the characters within
    #   the {CharSet}.
    #
    # @yieldparam [String] char
    #   Each character in the {CharSet}.
    #
    # @return [Array<String>]
    #   The mapped characters of the {CharSet}.
    #
    def map_chars(&block)
      each_char.map(&block)
    end

    #
    # Returns a random byte from the {CharSet}.
    #
    # @return [Integer]
    #   A random byte value.
    #
    def random_byte
      self.entries[rand(self.length)]
    end

    #
    # Returns a random character from the {CharSet}.
    #
    # @return [String]
    #   A random char value.
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
    #   The random byte from the {CharSet}.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_random_byte(n,&block)
      return enum_for(__method__,n) unless block_given?

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
    #   The random character from the {CharSet}.
    #
    # @return [Enumerator]
    #   If no block is given, an enumerator object will be returned.
    #
    def each_random_char(n,&block)
      return enum_for(__method__,n) unless block_given?

      each_random_byte(n) { |byte| yield @chars[byte] }
    end

    #
    # Creates an Array of random bytes from the {CharSet}.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random bytes.
    #
    # @return [Array<Integer>]
    #   The randomly selected bytes.
    #
    def random_bytes(length)
      case length
      when Array
        Array.new(length.sample) { random_byte }
      when Range
        Array.new(rand(length)) { random_byte }
      else
        Array.new(length) { random_byte }
      end
    end

    #
    # Creates an Array of random non-repeating bytes from the {CharSet}.
    #
    # @param [Integer, Array, Range] length
    #   The length of the Array of random non-repeating bytes.
    #
    # @return [Array<Integer>]
    #   The randomly selected non-repeating bytes.
    #
    def random_distinct_bytes(length)
      shuffled_bytes = bytes.shuffle

      case length
      when Array
        shuffled_bytes[0,length.sample]
      when Range
        shuffled_bytes[0,rand(length)]
      else
        shuffled_bytes[0,length]
      end
    end

    #
    # Creates an Array of random characters from the {CharSet}.
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
    # {CharSet}.
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
    # {CharSet}.
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
    # characters from the {CharSet}.
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
    # Enumerates over all substrings and their indices within the given string,
    # of minimum length and that are made up of characters from the {CharSet}.
    #
    # @param [String] data
    #   The data to find sub-strings within.
    #
    # @param [Integer] min_length
    #   The minimum length of sub-strings found within the given data.
    #
    # @yield [match, index]
    #   The given block will be passed every matched sub-string and it's index.
    #
    # @yield [String] match
    #   A sub-string containing the characters from the {CharSet}.
    #
    # @yield [Integer] index
    #   The index the sub-string was found at.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    # @since 0.3.0
    #
    def each_substring_with_index(data, min_length: 4)
      unless block_given?
        return enum_for(__method__,data, min_length: min_length)
      end

      return if data.size < min_length

      index = 0

      match_start = nil
      match_end   = nil

      while index < data.size
        unless match_start
          if self.include_char?(data[index])
            match_start = index
          end
        else
          unless self.include_char?(data[index])
            match_end    = index
            match_length = (match_end - match_start)

            if match_length >= min_length
              match = data[match_start,match_length]

              yield match, match_start
            end

            match_start = match_end = nil
          end
        end

        index += 1
      end

      # yield the remaining match
      if match_start
        yield data[match_start, data.size - match_start], match_start
      end
    end

    #
    # Returns an Array of all substrings and their indices within the given
    # string, of minimum length and that are made up of characters from the
    # {CharSet}.
    #
    # @param [String] data
    #   The data to find sub-strings within.
    #
    # @param [Hash{Symbol => Object}] kwargs
    #   Keyword arguments for {#each_substring_with_index}.
    #
    # @option kwargs [Integer] :min_length
    #   The minimum length of sub-strings found within the given data.
    #
    # @return [Array<(String, Integer)>]
    #   Tthe array of substrings and their indices within the given `data`.
    #
    # @see #each_substring_with_index
    #
    # @since 0.3.0
    #
    def substrings_with_indexes(data,**kwargs)
      each_substring_with_index(data,**kwargs).to_a
    end

    #
    # Enumerates over all substrings within the given string, of minimum length
    # and that are made up of characters from the {CharSet}.
    #
    # @param [String] data
    #   The data to find sub-strings within.
    #
    # @param [Hash{Symbol => Object}] kwargs
    #   Keyword arguments for {#each_substring_with_index}.
    #
    # @option kwargs [Integer] :min_length
    #   The minimum length of sub-strings found within the given data.
    #
    # @return [Enumerator]
    #   If no block is given, an Enumerator object will be returned.
    #
    # @see #each_substring_with_index
    #
    # @since 0.3.0
    #
    def each_substring(data,**kwargs)
      return enum_for(__method__,data,**kwargs) unless block_given?

      each_substring_with_index(data,**kwargs) do |substring,index|
        yield substring
      end
    end

    #
    # Returns an Array of all substrings within the given string,
    # of minimum length and that are made up of characters from the {CharSet}.
    #
    # @param [String] data
    #   The data to find sub-strings within.
    #
    # @param [Hash{Symbol => Object}] kwargs
    #   Keyword arguments for {#each_substring_with_index}.
    #
    # @option kwargs [Integer] :min_length
    #   The minimum length of sub-strings found within the given data.
    #
    # @see #each_substring
    #
    # @return [Array<String>]
    #   Tthe array of substrings within the given `data`.
    #
    # @since 0.3.0
    #
    def substrings(data,**kwargs)
      each_substring(data,**kwargs).to_a
    end

    #
    # Finds sub-strings within given data that are made of characters within
    # the {CharSet}.
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
    # @yield [match,(index)]
    #   The given block will be passed every matched sub-string, and the
    #   optional index.
    #
    # @yield [String] match
    #   A sub-string containing the characters from the {CharSet}.
    #
    # @yield [Integer] index
    #   The index the sub-string was found at.
    #
    # @return [Array, Hash]
    #   If no block is given, an Array or Hash of sub-strings is returned.
    #
    def strings_in(data,options={},&block)
      unless block
        if options[:offsets]
          found = {}
          block = lambda { |offset,substring| found[offset] = substring }
        else
          found = []
          block = lambda { |substring| found << substring }
        end

        strings_in(data,options,&block)
        return found
      end

      min_length = options.fetch(:length,4)
      return if data.length < min_length

      index = 0

      while index <= (data.length - min_length)
        if self === data[index,min_length]
          sub_index = (index + min_length)

          while self.include_char?(data[sub_index,1])
            sub_index += 1
          end

          match = data[index...sub_index]

          case block.arity
          when 2
            yield match, index
          else
            yield match
          end

          index = sub_index
        else
          index += 1
        end
      end
    end

    #
    # Creates a new CharSet object by unioning the {CharSet} with another
    # {CharSet}.
    #
    # @param [CharSet, Array, Range] set
    #   The other {CharSet} to union with.
    #
    # @return [CharSet]
    #   The unioned {ChraSet}.
    #
    def |(set)
      set = CharSet.new(set) unless set.kind_of?(CharSet)

      return super(set)
    end

    alias + |

    #
    # Compares the bytes within a given string with the bytes of the
    # {CharSet}.
    #
    # @param [String, Enumerable] other
    #   The string to compare with the {CharSet}.
    #
    # @return [Boolean]
    #   Specifies whether all of the bytes within the given string are
    #   included in the {CharSet}.
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
    # Inspects the {CharSet}.
    #
    # @return [String]
    #   The inspected {CharSet}.
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
          sprintf("0x%02x",byte)
        end
      }.join(', ') + "}>"
    end

  end
end
