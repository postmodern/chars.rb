require 'chars/chars'

class String

  def numeric?
    Chars::NUMERIC =~ self
  end

  def octal?
    Chars::OCTAL =~ self
  end

  def uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL =~ self
  end

  def lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL =~ self
  end

  def hex?
    Chars::HEXADECIMAL =~ self
  end

  def uppercase_alpha?
    Chars::UPPERCASE_ALPHA =~ self
  end

  def lowercase_alpha?
    Chars::LOWERCASE_ALPHA =~ self
  end

  def alpha?
    Chars::ALPHA =~ self
  end

  def alpha_numeric?
    Chars::ALPHA_NUMERIC =~ self
  end

  def punctuation?
    Chars::PUNCTUATION =~ self
  end

  def symbolic?
    Chars::SYMBOLS =~ self
  end

  def space?
    Chars::SPACE =~ self
  end

  def printable?
    Chars::PRINTABLE =~ self
  end

  def control?
    Chars::CONTROL =~ self
  end

  def ascii?
    Chars::ASCII =~ self
  end

end
