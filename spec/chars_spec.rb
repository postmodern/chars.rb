require 'spec_helper'
require 'chars/chars'

describe Chars do
  it "should provide a numeric CharSet" do
    expect(described_class::NUMERIC).to be =~ '0123456789'
  end

  it "should provide an octal CharSet" do
    expect(described_class::OCTAL).to be =~ "01234567"
  end

  it "should provide an upper-case hexadecimal CharSet" do
    expect(described_class::UPPERCASE_HEXADECIMAL).to be =~ "0123456789ABCDEF"
  end

  it "should provide a lower-case hexadecimal CharSet" do
    expect(described_class::LOWERCASE_HEXADECIMAL).to be =~ "0123456789abcdef"
  end

  it "should provide a hexadecimal CharSet" do
    expect(described_class::HEXADECIMAL).to be =~ "0123456789ABCDEFabcdef"
  end

  it "should provide an upper-case alpha CharSet" do
    expect(described_class::UPPERCASE_ALPHA).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  end

  it "should provide a lower-case alpha CharSet" do
    expect(described_class::LOWERCASE_ALPHA).to be =~ "abcdefghijklmnopqrstuvwxyz"
  end

  it "should provide an alpha CharSet" do
    expect(described_class::ALPHA).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  end

  it "should provide an alpha-numeric CharSet" do
    expect(described_class::ALPHA_NUMERIC).to be =~ "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  end
  
  it "should provide a visible CharSet" do
    expect(described_class::VISIBLE).to be =~ "!\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  end

  it "should provide a space CharSet" do
    expect(described_class::SPACE).to be =~ "\t\n\v\f\r "
  end

  it "should provide a punctuation CharSet" do
    expect(described_class::PUNCTUATION).to be =~ " !\"'(),-.:;?[]`{}~"
  end

  it "should provide a symbols CharSet" do
    expect(described_class::SYMBOLS).to be =~ " !\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
  end
end
