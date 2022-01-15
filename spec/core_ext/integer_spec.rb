require 'spec_helper'
require 'chars/extensions/integer'

describe Integer do
  it "should recognize numeric bytes" do
    expect(0x39).to be_numeric
  end

  it "should recognize octal bytes" do
    expect(0x30).to be_octal
  end

  it "should recognize upper-case hexadecimal bytes" do
    expect(0x44).to be_uppercase_hex
  end

  it "should recognize lower-case hexadecimal bytes" do
    expect(0x61).to be_lowercase_hex
  end

  it "should recognize hexadecimal bytes" do
    expect(0x63).to be_hex
  end

  it "should recognize upper-case alpha bytes" do
    expect(0x4c).to be_uppercase_alpha
  end

  it "should recognize lower-case alpha bytes" do
    expect(0x71).to be_lowercase_alpha
  end

  it "should recognize alpha bytes" do
    expect(0x7a).to be_alpha
  end

  it "should recognize alpha-numeric bytes" do
    expect(0x69).to be_alpha_numeric
  end

  it "should recognize punctuation bytes" do
    expect(0x60).to be_punctuation
  end

  it "should recognize symbolic bytes" do
    expect(0x26).to be_symbolic
  end

  it "should recognize space bytes" do
    expect(0x20).to be_space
  end

  it "should recognize visible bytes" do
    expect(0x41).to be_visible
    expect(0x20).to_not be_visible
  end

  it "should recognize printable bytes" do
    expect(0x3f).to be_printable
  end

  it "should recognize control bytes" do
    expect(0x1b).to be_control
  end

  it "should recognize signed ASCII bytes" do
    expect(0x00).to be_signed_ascii
  end

  it "should recognize ASCII bytes" do
    expect(0x80).to be_ascii
  end
end
