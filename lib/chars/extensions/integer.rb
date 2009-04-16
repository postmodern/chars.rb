require 'chars/chars'

class Integer

  def numeric?
    Chars::NUMERIC.include?(self)
  end

  def octal?
    Chars::OCTAL.include?(self)
  end

  def uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL.include?(self)
  end

  def lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL.include?(self)
  end

  def hex?
    Chars::HEXADECIMAL.include?(self)
  end

  def uppercase_alpha?
    Chars::UPPERCASE_ALPHA.include?(self)
  end

  def lowercase_alpha?
    Chars::LOWERCASE_ALPHA.include?(self)
  end

  def alpha?
    Chars::ALPHA.include?(self)
  end

  def alpha_numeric?
    Chars::ALPHA_NUMERIC.include?(self)
  end

  def punctuation?
    Chars::PUNCTUATION.include?(self)
  end

  def symbolic?
    Chars::SYMBOLS.include?(self)
  end

  def space?
    Chars::SPACE.include?(self)
  end

  def printable?
    Chars::PRINTABLE.include?(self)
  end

  def control?
    Chars::CONTROL.include?(self)
  end

  def signed_ascii?
    Chars::SIGNED_ASCII.include?(self)
  end

  def ascii?
    Chars::ASCII.include?(self)
  end

end
