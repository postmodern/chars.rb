# encoding: US-ASCII

require 'spec_helper'
require 'chars/extensions/string'

describe String do
  it "should recognize numeric strings" do
    expect("0987").to be_numeric
  end

  it "should recognize octal strings" do
    expect("012").to be_octal
  end

  it "should recognize upper-case hexadecimal strings" do
    expect("2D").to be_uppercase_hex
  end

  it "should recognize lower-case hexadecimal strings" do
    expect("2d").to be_lowercase_hex
  end

  it "should recognize hexadecimal strings" do
    expect("2dE3").to be_hex
  end

  it "should recognize upper-case alpha strings" do
    expect("ABC").to be_uppercase_alpha
  end

  it "should recognize lower-case alpha strings" do
    expect("abc").to be_lowercase_alpha
  end

  it "should recognize alpha strings" do
    expect("abcDEF").to be_alpha
  end

  it "should recognize alpha-numeric strings" do
    expect("abc123").to be_alpha_numeric
  end

  it "should recognize punctuation strings" do
    expect("[...]").to be_punctuation
  end

  it "should recognize symbolic strings" do
    expect("++").to be_symbolic
  end

  it "should recognize space strings" do
    expect("  \t").to be_space
  end

  it "should recognize visible strings" do
    expect("abc").to be_visible
    expect("ab c").to_not be_visible
  end

  it "should recognize printable strings" do
    expect("abc, [123]\nDEF").to be_printable
  end

  it "should recognize control strings" do
    expect("\b\b\a").to be_control
  end

  it "should recognize signed ASCII strings" do
    expect("lol\0").to be_signed_ascii
  end

  it "should recognize ASCII strings" do
    expect("\xff\xfe").to be_ascii
  end
end
