# frozen_string_literal: true

require 'chars/char_set'

module Chars
  # The numeric decimal character set
  NUMERIC = CharSet['0'..'9']

  # The octal character set
  OCTAL = CharSet['0'..'7']

  # The upper-case hexadecimal character set
  UPPERCASE_HEXADECIMAL = NUMERIC | CharSet['A'..'F']

  # The lower-case hexadecimal character set
  LOWERCASE_HEXADECIMAL = NUMERIC | CharSet['a'..'f']

  # The hexadecimal character set
  HEXADECIMAL = UPPERCASE_HEXADECIMAL | LOWERCASE_HEXADECIMAL

  # The upper-case alpha character set
  UPPERCASE_ALPHA = CharSet['A'..'Z']

  # The lower-case alpha character set
  LOWERCASE_ALPHA = CharSet['a'..'z']

  # The alpha character set
  ALPHA = UPPERCASE_ALPHA | LOWERCASE_ALPHA

  # The alpha-numeric character set
  ALPHA_NUMERIC = ALPHA | NUMERIC

  # The punctuation character set
  PUNCTUATION = CharSet[' ', '\'', '"', '`', ',', ';', ':', '~', '-',
                        '(', ')', '[', ']', '{', '}', '.', '?', '!']

  # The symbolic character set
  SYMBOLS = PUNCTUATION | CharSet[
    '@', '#', '$', '%', '^', '&', '*', '_', '+',
    '=', '|', '\\', '<', '>', '/'
  ]

  # The space character set
  SPACE = CharSet[' ', "\f", "\n", "\r", "\t", "\v"]

  # The set of printable characters (not including spaces)
  VISIBLE = ALPHA_NUMERIC | CharSet[
    '\'', '"', '`', ',', ';', ':', '~', '-',
    '(', ')', '[', ']', '{', '}', '.', '?', '!', '@', '#', '$',
    '%', '^', '&', '*', '_', '+', '=', '|', '\\', '<', '>', '/'
  ]
  
  # The set of printable characters (including spaces)
  PRINTABLE = ALPHA_NUMERIC | PUNCTUATION | SYMBOLS | SPACE

  # The control-char character set
  CONTROL = CharSet[0..0x1f, 0x7f]

  # The signed ASCII character set
  SIGNED_ASCII = CharSet[0..0x7f]

  # The full 8-bit character set
  ASCII = CharSet[0..0xff]

  #
  # The decimal-digit character set.
  #
  # @return [CharSet]
  #   The decimal-digit character set.
  #
  # @see NUMERIC
  #
  def self.numeric
    NUMERIC
  end

  #
  # The octal-digit character set.
  #
  # @return [CharSet]
  #   The octal-digit character set.
  #
  # @see OCTAL
  #
  def self.octal
    OCTAL
  end

  #
  # The upper-case hexadecimal character set.
  #
  # @return [CharSet]
  #   The upper-case hexadecimal character set.
  #
  # @see UPPERCASE_HEXADECIMAL
  #
  def self.uppercase_hexadecimal
    UPPERCASE_HEXADECIMAL
  end

  #
  # The lower-case hexadecimal character set.
  #
  # @return [CharSet]
  #   The lower-case hexadecimal character set.
  #
  # @see LOWERCASE_HEXADECIMAL
  #
  def self.lowercase_hexadecimal
    LOWERCASE_HEXADECIMAL
  end

  #
  # The hexadecimal character set.
  #
  # @return [CharSet]
  #   The hexadecimal character set.
  #
  # @see HEXADECIMAL
  #
  def self.hexadecimal
    HEXADECIMAL
  end

  #
  # The upper-case alphabetic character set.
  #
  # @return [CharSet]
  #   The upper-case alphabetic character set.
  #
  # @see UPPERCASE_ALPHA
  #
  def self.uppercase_alpha
    UPPERCASE_ALPHA
  end

  #
  # The lower-case alphabetic character set.
  #
  # @return [CharSet]
  #   The lower-case alphabetic character set.
  #
  # @see LOWERCASE_ALPHA
  #
  def self.lowercase_alpha
    LOWERCASE_ALPHA
  end

  #
  # The alphabetic character set.
  #
  # @return [CharSet]
  #   The alphabetic character set.
  #
  # @see ALPHA
  #
  def self.alpha
    ALPHA
  end

  #
  # The alpha-numeric character set.
  #
  # @return [CharSet]
  #   The alpha-numeric character set.
  #
  # @see ALPHA_NUMERIC
  #
  def self.alpha_numeric
    ALPHA_NUMERIC
  end

  #
  # The punctuation character set.
  #
  # @return [CharSet]
  #   The punctuation character set.
  #
  # @see PUNCTUATION
  #
  def self.punctuation
    PUNCTUATION
  end

  #
  # The symbolic character set.
  #
  # @return [CharSet]
  #   The symbolic character set.
  #
  # @see SYMBOLS
  #
  def self.symbols
    SYMBOLS
  end

  #
  # The white-space character set.
  #
  # @return [CharSet]
  #   The white-space character set.
  #
  # @see SPACE
  #
  def self.space
    SPACE
  end

  #
  # The set of printable characters, not including spaces.
  #
  # @return [CharSet]
  #   The visible character set.
  #
  # @see VISIBLE
  #
  def self.visible
    VISIBLE
  end

  #
  # The set of printable characters, including spaces.
  #
  # @return [CharSet]
  #   The printable character set.
  #
  # @see PRINTABLE
  #
  def self.printable
    PRINTABLE
  end

  #
  # The control-character character set.
  #
  # @return [CharSet]
  #   The control-character character set.
  #
  # @see CONTROL
  #
  def self.control
    CONTROL
  end

  #
  # The signed ASCII character set.
  #
  # @return [CharSet]
  #   The signed ASCII character set.
  #
  # @see SIGNED_ASCII
  #
  def self.signed_ascii
    SIGNED_ASCII
  end

  #
  # The ASCII character set.
  #
  # @return [CharSet]
  #   The ASCII character set.
  #
  # @see ASCII
  #
  def self.ascii
    ASCII
  end
end
