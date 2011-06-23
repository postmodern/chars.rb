require 'spec_helper'
require 'chars/extensions/integer'

describe Integer do
  it "should recognize numeric bytes" do
    0x39.should be_numeric
  end

  it "should recognize octal bytes" do
    0x30.should be_octal
  end

  it "should recognize upper-case hexadecimal bytes" do
    0x44.should be_uppercase_hex
  end

  it "should recognize lower-case hexadecimal bytes" do
    0x61.should be_lowercase_hex
  end

  it "should recognize hexadecimal bytes" do
    0x63.should be_hex
  end

  it "should recognize upper-case alpha bytes" do
    0x4c.should be_uppercase_alpha
  end

  it "should recognize lower-case alpha bytes" do
    0x71.should be_lowercase_alpha
  end

  it "should recognize alpha bytes" do
    0x7a.should be_alpha
  end

  it "should recognize alpha-numeric bytes" do
    0x69.should be_alpha_numeric
  end

  it "should recognize punctuation bytes" do
    0x60.should be_punctuation
  end

  it "should recognize symbolic bytes" do
    0x26.should be_symbolic
  end

  it "should recognize space bytes" do
    0x20.should be_space
  end

  it "should recognize visible bytes" do
    0x41.should be_visible
    0x20.should_not be_visible
  end

  it "should recognize printable bytes" do
    0x3f.should be_printable
  end

  it "should recognize control bytes" do
    0x1b.should be_control
  end

  it "should recognize signed ASCII bytes" do
    0x00.should be_signed_ascii
  end

  it "should recognize ASCII bytes" do
    0x80.should be_ascii
  end
end
