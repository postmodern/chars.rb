require 'chars/chars'

class String

  #
  # Determines whether the String belongs to the decimal-digit character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the decimal-digit character
  #   set.
  #
  # @see Chars.numeric
  #
  def numeric?
    Chars::NUMERIC === self
  end

  #
  # Determines whether the String belongs to the octal-digit character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the octal-digit character
  #   set.
  #
  # @see Chars.octal
  #
  def octal?
    Chars::OCTAL === self
  end

  #
  # Determines whether the String belongs to the upper-case hexadecimal
  # character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the upper-case hexadecimal
  #   character set.
  #
  # @see Chars.uppercase_hexadecimal
  #
  def uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL === self
  end

  #
  # Determines whether the String belongs to the lower-case hexadecimal
  # character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the lower-case hexadecimal
  #   character set.
  #
  # @see Chars.lowercase_hexadecimal
  #
  def lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL === self
  end

  #
  # Determines whether the String belongs to the hexadecimal character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the hexadecimal character set.
  #
  # @see Chars.hexadecimal
  #
  def hex?
    Chars::HEXADECIMAL === self
  end

  #
  # Determines whether the String belongs to the upper-case alphabetic
  # character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the upper-case alphabetic
  #   character set.
  #
  # @see Chars.uppercase_alpha
  #
  def uppercase_alpha?
    Chars::UPPERCASE_ALPHA === self
  end

  #
  # Determines whether the String belongs to the lower-case alphabetic
  # character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the lower-case alphabetic
  #   character set.
  #
  # @see Chars.lowercase_alpha
  #
  def lowercase_alpha?
    Chars::LOWERCASE_ALPHA === self
  end

  #
  # Determines whether the String belongs to the alphabetic character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the alphabetic character set.
  #
  # @see Chars.alpha
  #
  def alpha?
    Chars::ALPHA === self
  end

  #
  # Determines whether the String belongs to the alpha-numeric character
  # set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the alpha-numeric character
  #   set.
  #
  # @see Chars.alpha_numeric
  #
  def alpha_numeric?
    Chars::ALPHA_NUMERIC === self
  end

  #
  # Determines whether the String belongs to the punctuation character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the punctuation character set.
  #
  # @see Chars.punctuation
  #
  def punctuation?
    Chars::PUNCTUATION === self
  end

  #
  # Determines whether the String belongs to the symbolic character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the symbolic character set.
  #
  # @see Chars.symbols
  #
  def symbolic?
    Chars::SYMBOLS === self
  end

  #
  # Determines whether the String belongs to the white-space character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the white-space character set.
  #
  # @see Chars.space
  #
  def space?
    Chars::SPACE === self
  end

  #
  # Determines whether the String belongs to the visible character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the visible character set.
  #
  # @see Chars.visible
  #
  def visible?
    Chars::VISIBLE === self
  end

  #
  # Determines whether the String belongs to the printable character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the printable character set.
  #
  # @see Chars.printable
  #
  def printable?
    Chars::PRINTABLE === self
  end

  #
  # Determines whether the String belongs to the control-character
  # character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the control-character
  #   character set.
  #
  # @see Chars.control
  #
  def control?
    Chars::CONTROL === self
  end

  #
  # Determines whether the String belongs to the signed-ASCII character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the signed-ASCII character
  #   set.
  #
  # @see Chars.signed_ascii
  #
  def signed_ascii?
    Chars::SIGNED_ASCII === self
  end

  #
  # Determines whether the String belongs to the ASCII character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the ASCII character set.
  #
  # @see Chars.ascii
  #
  def ascii?
    Chars::ASCII === self
  end

end
