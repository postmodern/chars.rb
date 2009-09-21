require 'chars/char_set'

module Chars
  # The numeric decimal character set
  NUMERIC = CharSet.new('0'..'9')

  # The octal character set
  OCTAL = CharSet.new('0'..'7')

  # The upper-case hexadecimal character set
  UPPERCASE_HEXADECIMAL = NUMERIC + ('A'..'F')

  # The lower-case hexadecimal character set
  LOWERCASE_HEXADECIMAL = NUMERIC + ('a'..'f')

  # The hexadecimal character set
  HEXADECIMAL = UPPERCASE_HEXADECIMAL + LOWERCASE_HEXADECIMAL

  # The upper-case alpha character set
  UPPERCASE_ALPHA = CharSet.new('A'..'Z')

  # The lower-case alpha character set
  LOWERCASE_ALPHA = CharSet.new('a'..'z')

  # The alpha character set
  ALPHA = UPPERCASE_ALPHA + LOWERCASE_ALPHA

  # The alpha-numeric character set
  ALPHA_NUMERIC = ALPHA + NUMERIC

  # The punctuation character set
  PUNCTUATION = CharSet.new(' ', '\'', '"', '`', ',', ';', ':', '~', '-',
                            '(', ')', '[', ']', '{', '}', '.', '?', '!')

  # The symbolic character set
  SYMBOLS = PUNCTUATION + ['@', '#', '$', '%', '^', '&', '*', '_', '+',
    '=', '|', '\\', '<', '>', '/']

  # The space character set
  SPACE = CharSet.new(' ', "\f", "\n", "\r", "\t", "\v")

  # The set of printable characters (not including spaces)
  VISIBLE = ALPHA_NUMERIC + ['\'', '"', '`', ',', ';', ':', '~', '-',
            '(', ')', '[', ']', '{', '}', '.', '?', '!', '@', '#', '$',
            '%', '^', '&', '*', '_', '+', '=', '|', '\\', '<', '>', '/']
  
  # The set of printable characters (including spaces)
  PRINTABLE = ALPHA_NUMERIC + PUNCTUATION + SYMBOLS + SPACE

  # The control-char character set
  CONTROL = CharSet.new(0..0x1f, 0x7f)

  # The signed ASCII character set
  SIGNED_ASCII = CharSet.new(0..0x7f)

  # The full 8-bit character set
  ASCII = CharSet.new(0..0xff)

  #
  # The numeric decimal character set.
  #
  # @return [CharSet]
  #   The numeric decimal character set.
  #
  def Chars.numeric
    NUMERIC
  end

  #
  # The octal character set.
  #
  # @return [CharSet]
  #   The octal character set.
  #
  def Chars.octal
    OCTAL
  end

  #
  # The upper-case hexadecimal character set.
  #
  # @return [CharSet]
  #   The upper-case hexadecimal character set.
  #
  def Chars.uppercase_hexadecimal
    UPPERCASE_HEXADECIMAL
  end

  #
  # The lower-case hexadecimal character set.
  #
  # @return [CharSet]
  #   The lower-case hexadecimal character set.
  #
  def Chars.lowercase_hexadecimal
    LOWERCASE_HEXADECIMAL
  end

  #
  # The hexadecimal character set.
  #
  # @return [CharSet]
  #   The hexadecimal character set.
  #
  def Chars.hexadecimal
    HEXADECIMAL
  end

  #
  # The upper-case alpha character set.
  #
  # @return [CharSet]
  #   The upper-case alpha character set.
  #
  def Chars.uppercase_alpha
    UPPERCASE_ALPHA
  end

  #
  # The lower-case alpha character set.
  #
  # @return [CharSet]
  #   The lower-case alpha character set.
  #
  def Chars.lowercase_alpha
    LOWERCASE_ALPHA
  end

  #
  # The alpha character set.
  #
  # @return [CharSet]
  #   The alpha character set.
  #
  def Chars.alpha
    ALPHA
  end

  #
  # The alpha-numeric character set.
  #
  # @return [CharSet]
  #   The alpha-numeric character set.
  #
  def Chars.alpha_numeric
    ALPHA_NUMERIC
  end

  #
  # The punctuation character set.
  #
  # @return [CharSet]
  #   The punctuation character set.
  #
  def Chars.punctuation
    PUNCTUATION
  end

  #
  # The symbolic character set.
  #
  # @return [CharSet]
  #   The symbolic character set.
  #
  def Chars.symbols
    SYMBOLS
  end

  #
  # The space character set.
  #
  # @return [CharSet]
  #   The space character set.
  #
  def Chars.space
    SPACE
  end

  #
  # The set of printable characters, not including spaces.
  #
  # @return [CharSet]
  #   The visible character set.
  #
  def Chars.visible
    VISIBLE
  end

  #
  # The set of printable characters, including spaces.
  #
  # @return [CharSet]
  #   The printable character set.
  #
  def Chars.printable
    PRINTABLE
  end

  #
  # The control-char character set.
  #
  # @return [CharSet]
  #   The control-character set.
  #
  def Chars.control
    CONTROL
  end

  #
  # The signed ASCII character set.
  #
  # @return [CharSet]
  #   The signed ASCII character set.
  #
  def Chars.signed_ascii
    SIGNED_ASCII
  end

  #
  # The ASCII character set.
  #
  # @return [CharSet]
  #   The ASCII character set.
  #
  def Chars.ascii
    ASCII
  end
end
