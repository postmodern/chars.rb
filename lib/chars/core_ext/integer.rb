require 'chars/chars'

class Integer

  #
  # Determines if the byte belongs to the decimal-digit character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the decimal-digit character set.
  #
  # @see Chars::NUMERIC
  # @see Chars::CharSet#include_byte?
  #
  def numeric?
    Chars::NUMERIC.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the octal-digit character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the octal-digit character set.
  #
  # @see Chars::OCTAL
  # @see Chars::CharSet#include_byte?
  #
  def octal?
    Chars::OCTAL.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the upper-case hexadecimal character
  # set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the upper-case hexadecimal
  #   character set.
  #
  # @see Chars::UPPERCASE_HEXADECIMAL
  # @see Chars::CharSet#include_byte?
  #
  def uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the lower-case hexadecimal character
  # set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the lower-case hexadecimal
  #   character set.
  #
  # @see Chars::LOWERCASE_HEXADECIMAL
  # @see Chars::CharSet#include_byte?
  #
  def lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the hexadecimal character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the hexadecimal character set.
  #
  # @see Chars::HEXADECIMAL
  # @see Chars::CharSet#include_byte?
  #
  def hex?
    Chars::HEXADECIMAL.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the upper-case alphabetic character
  # set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the upper-case alphabetic
  #   character set.
  #
  # @see Chars::UPPERCASE_ALPHA
  # @see Chars::CharSet#include_byte?
  #
  def uppercase_alpha?
    Chars::UPPERCASE_ALPHA.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the lower-case alphabetic character
  # set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the lower-case alphabetic
  #   character set.
  #
  # @see Chars::LOWERCASE_ALPHA
  # @see Chars::CharSet#include_byte?
  #
  def lowercase_alpha?
    Chars::LOWERCASE_ALPHA.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the alphabetic character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the alphabetic character set.
  #
  # @see Chars::ALPHA
  # @see Chars::CharSet#include_byte?
  #
  def alpha?
    Chars::ALPHA.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the alpha-numeric character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the alpha-numeric character set.
  #
  # @see Chars::ALPHA_NUMERIC
  # @see Chars::CharSet#include_byte?
  #
  def alpha_numeric?
    Chars::ALPHA_NUMERIC.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the punctuation character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the punctuation character set.
  #
  # @see Chars::PUNCTUATION
  # @see Chars::CharSet#include_byte?
  #
  def punctuation?
    Chars::PUNCTUATION.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the symbolic character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the symbolic character set.
  #
  # @see Chars::SYMBOLS
  # @see Chars::CharSet#include_byte?
  #
  def symbolic?
    Chars::SYMBOLS.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the white-space character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the white-space character set.
  #
  # @see Chars::SPACE
  # @see Chars::CharSet#include_byte?
  #
  def space?
    Chars::SPACE.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the visible character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the visible character set.
  #
  # @see Chars::VISIBLE
  # @see Chars::CharSet#include_byte?
  #
  def visible?
    Chars::VISIBLE.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the printable character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the printable character set.
  #
  # @see Chars::PRINTABLE
  # @see Chars::CharSet#include_byte?
  #
  def printable?
    Chars::PRINTABLE.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the control-character character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the control-character character
  #   set.
  #
  # @see Chars::CONTROL
  # @see Chars::CharSet#include_byte?
  #
  def control?
    Chars::CONTROL.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the signed-ASCII character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the signed-ASCII character set.
  #
  # @see Chars::SIGNED_ASCII
  # @see Chars::CharSet#include_byte?
  #
  def signed_ascii?
    Chars::SIGNED_ASCII.include_byte?(self)
  end

  #
  # Determines if the byte belongs to the ASCII character set.
  #
  # @return [Boolean]
  #   Specifies whether the byte belongs to the ASCII character set.
  #
  # @see Chars::ASCII
  # @see Chars::CharSet#include_byte?
  #
  def ascii?
    Chars::ASCII.include_byte?(self)
  end

end
