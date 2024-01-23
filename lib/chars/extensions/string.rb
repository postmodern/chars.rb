require_relative '../chars'

class String

  #
  # Determines whether the String belongs to the decimal-digit character set.
  #
  # @return [Boolean]
  #   Specifies whether the String belongs to the decimal-digit character
  #   set.
  #
  # @see Chars::NUMERIC
  # @see Chars::CharSet#===
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
  # @see Chars::OCTAL
  # @see Chars::CharSet#===
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
  # @see Chars::UPPERCASE_HEXADECIMAL
  # @see Chars::CharSet#===
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
  # @see Chars::LOWERCASE_HEXADECIMAL
  # @see Chars::CharSet#===
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
  # @see Chars::HEXADECIMAL
  # @see Chars::CharSet#===
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
  # @see Chars::UPPERCASE_ALPHA
  # @see Chars::CharSet#===
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
  # @see Chars::LOWERCASE_ALPHA
  # @see Chars::CharSet#===
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
  # @see Chars::ALPHA
  # @see Chars::CharSet#===
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
  # @see Chars::ALPHA_NUMERIC
  # @see Chars::CharSet#===
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
  # @see Chars::PUNCTUATION
  # @see Chars::CharSet#===
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
  # @see Chars::SYMBOLS
  # @see Chars::CharSet#===
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
  # @see Chars::SPACE
  # @see Chars::CharSet#===
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
  # @see Chars::VISIBLE
  # @see Chars::CharSet#===
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
  # @see Chars::PRINTABLE
  # @see Chars::CharSet#===
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
  # @see Chars::CONTROL
  # @see Chars::CharSet#===
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
  # @see Chars::SIGNED_ASCII
  # @see Chars::CharSet#===
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
  # @see Chars::ASCII
  # @see Chars::CharSet#===
  #
  def ascii?
    Chars::ASCII === self
  end

end
