require 'chars/chars'

class String

  def is_numeric?
    Chars::NUMERIC =~ self
  end

  def is_octal?
    Chars::OCTAL =~ self
  end

  def is_uppercase_hex?
    Chars::UPPERCASE_HEXADECIMAL =~ self
  end

  def is_lowercase_hex?
    Chars::LOWERCASE_HEXADECIMAL =~ self
  end

  def is_hex?
    Chars::HEXADECIMAL =~ self
  end

  def is_uppercase_alpha?
    Chars::UPPERCASE_ALPHA =~ self
  end

  def is_lowercase_alpha?
    Chars::LOWERCASE_ALPHA =~ self
  end

  def is_alpha?
    Chars::ALPHA =~ self
  end

  def is_alpha_numeric?
    Chars::ALPHA_NUMERIC =~ self
  end

  def is_punctuation?
    Chars::PUNCTUATION =~ self
  end

  def is_symbolic?
    Chars::SYMBOLS =~ self
  end

  def is_space?
    Chars::SPACE =~ self
  end

  def is_printable?
    Chars::PRINTABLE =~ self
  end

  def is_control?
    Chars::CONTROL =~ self
  end

  def is_ascii?
    Chars::ASCII =~ self
  end

end
