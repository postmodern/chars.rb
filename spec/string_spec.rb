require 'chars/extensions/string'

require 'spec_helper'

describe String do
  it "should recognize numeric strings" do
    "0987".should be_numeric
  end

  it "should recognize octal strings" do
    "012".should be_octal
  end

  it "should recognize upper-case hexadecimal strings" do
    "2D".should be_uppercase_hex
  end

  it "should recognize lower-case hexadecimal strings" do
    "2d".should be_lowercase_hex
  end

  it "should recognize hexadecimal strings" do
    "2dE3".should be_hex
  end

  it "should recognize upper-case alpha strings" do
    "ABC".should be_uppercase_alpha
  end

  it "should recognize lower-case alpha strings" do
    "abc".should be_lowercase_alpha
  end

  it "should recognize alpha strings" do
    "abcDEF".should be_alpha
  end

  it "should recognize alpha-numeric strings" do
    "abc123".should be_alpha_numeric
  end

  it "should recognize punctuation strings" do
    "[...]".should be_punctuation
  end

  it "should recognize symbolic strings" do
    "++".should be_symbolic
  end

  it "should recognize space strings" do
    "  \t".should be_space
  end

  it "should recognize printable strings" do
    "abc, [123]\nDEF".should be_printable
  end

  it "should recognize control strings" do
    "\b\b\a".should be_control
  end

  it "should recognize ASCII strings" do
    "lol\0".should be_ascii
  end
end
