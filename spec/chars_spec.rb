require 'spec_helper'
require 'chars/chars'

describe Chars do
  it "should provide a numeric CharSet" do
    Chars::NUMERIC =~ '0123456789'
  end

  it "should provide an octal CharSet" do
    Chars::OCTAL =~ "01234567"
  end

  it "should provide an upper-case hexadecimal CharSet" do
    Chars::UPPERCASE_HEXADECIMAL =~ "0123456789ABCDEF"
  end

  it "should provide a lower-case hexadecimal CharSet" do
    Chars::LOWERCASE_HEXADECIMAL =~ "0123456789abcdef"
  end

  it "should provide a hexadecimal CharSet" do
    Chars::HEXADECIMAL =~ "0123456789ABCDEFabcdef"
  end

  it "should provide an upper-case alpha CharSet" do
    Chars::UPPERCASE_ALPHA =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  end

  it "should provide a lower-case alpha CharSet" do
    Chars::LOWERCASE_ALPHA =~ "abcdefghijklmnopqrstuvwxyz"
  end

  it "should provide an alpha CharSet" do
    Chars::ALPHA =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  end

  it "should provide an alpha-numeric CharSet" do
    Chars::ALPHA_NUMERIC =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  end
  
  it "should provide a visible CharSet" do
    Chars::VISIBLE =~ "!\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  end

  it "should provide a space CharSet" do
    Chars::SPACE =~ "\t\n\v\f\r "
  end

  it "should provide a punctuation CharSet" do
    Chars::PUNCTUATION =~ " !\"'(),-.:;?[]`{}~"
  end

  it "should provide a symbols CharSet" do
    Chars::SYMBOLS =~ " !\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
  end
end
