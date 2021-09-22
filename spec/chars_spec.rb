require 'spec_helper'
require 'chars/chars'

describe Chars do
  let(:numeric_chars) { '0123456789'.chars }

  describe "NUMERIC" do
    subject { described_class::NUMERIC }

    it "must contain numeric characters" do
      expect(subject.chars).to match_array(numeric_chars)
    end
  end

  describe "DIGITS" do
    subject { described_class::DIGITS }

    it "must equal NUMERIC" do
      expect(subject).to be(described_class::NUMERIC)
    end
  end

  describe "OCTAL" do
    subject { described_class::OCTAL }

    it "must contain all octal characters" do
      expect(subject.chars).to match_array("01234567".chars)
    end
  end

  let(:uppercase_hex_chars) { "0123456789ABCDEF".chars }

  describe "UPPERCASE_HEXADECIMAL" do
    subject { described_class::UPPERCASE_HEXADECIMAL }

    it "must contain all upper-case hexadecimal characters" do
      expect(subject.chars).to match_array(uppercase_hex_chars)
    end
  end

  let(:lowercase_hex_chars) { "0123456789abcdef".chars }

  describe "LOWERCASE_HEXADECIMAL" do
    subject { described_class::LOWERCASE_HEXADECIMAL }

    it "must contain all lower-case hexadecimal characters" do
      expect(subject.chars).to match_array(lowercase_hex_chars)
    end
  end

  describe "HEXADECIMAL" do
    subject { described_class::HEXADECIMAL }

    it "must contain both upper-case and lower-case hexadecimal characters" do
      expect(subject.chars).to match_array(uppercase_hex_chars | lowercase_hex_chars)
    end
  end

  let(:uppercase_alpha_chars) { "ABCDEFGHIJKLMNOPQRSTUVWXYZ".chars }

  describe "UPPERCASE_ALPHA" do
    subject { described_class::UPPERCASE_ALPHA }

    it "must contain all upper-case alpha characters" do
      expect(subject.chars).to match_array(uppercase_alpha_chars)
    end
  end

  let(:lowercase_alpha_chars) { "abcdefghijklmnopqrstuvwxyz".chars }

  describe "LOWERCASE_ALPHA" do
    subject { described_class::LOWERCASE_ALPHA }

    it "must contain all lower-case alpha characters" do
      expect(subject.chars).to match_array(lowercase_alpha_chars)
    end
  end

  let(:alpha_chars) { uppercase_alpha_chars | lowercase_alpha_chars }

  describe "ALPHA" do
    subject { described_class::ALPHA }

    it "must contain all alpha characters" do
      expect(subject.chars).to match_array(alpha_chars)
    end
  end

  let(:alpha_numeric_chars) { alpha_chars | numeric_chars }

  describe "ALPHA_NUMERIC" do
    subject { described_class::ALPHA_NUMERIC }

    it "must contain all alpha-numeric characters" do
      expect(subject.chars).to match_array(alpha_numeric_chars)
    end
  end

  let(:punctuation_chars) { " !\"'(),-.:;?[]`{}~".chars }

  describe "PUNCTUATION" do
    subject { described_class::PUNCTUATION }

    it "must contain all punctuation characters" do
      expect(subject.chars).to match_array(punctuation_chars)
    end
  end

  let(:symbolic_chars) { " !\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~".chars }

  describe "SYMBOLS" do
    subject { described_class::SYMBOLS }

    it "must contain all symbolic characters" do
      expect(subject.chars).to match_array(symbolic_chars)
    end
  end

  let(:whitespace_chars) { "\t\n\v\f\r ".chars }

  describe "WHITESPACE" do
    subject { described_class::WHITESPACE }

    it "must contain all white-space characters" do
      expect(subject.chars).to match_array(whitespace_chars)
    end
  end

  describe "SPACE" do
    subject { described_class::SPACE }

    it "must equal WHITESPACE" do
      expect(subject).to be(described_class::WHITESPACE)
    end
  end

  describe "VISIBLE" do
    subject { described_class::VISIBLE }

    it "must contain all all alpha-numeric, symbols, and some punctuation" do
      expect(subject.chars).to match_array(alpha_numeric_chars | "!\"\#$%&'()*+,-./:;<=>?@[\\]^_`{|}~".chars)
    end
  end

  describe "PRINTABLE" do
    subject { described_class::PRINTABLE }

    it "must contain all alpha-numeric, punctuation, symbols, and whitespace characters" do
      expect(subject.chars).to match_array(
        alpha_numeric_chars |
        punctuation_chars |
        symbolic_chars |
        whitespace_chars
      )
    end
  end

  describe "CONTROL" do
    subject { described_class::CONTROL }

    it "must contain ASCII bytes 0x00 - 0x1f and 0x7f" do
      expect(subject.bytes).to eq([*0x00..0x1f, 0x7f])
    end
  end

  describe "SIGNED_ASCII" do
    subject { described_class::SIGNED_ASCII }

    it "must contain ASCII bytes 0x00 - 0x7f" do
      expect(subject.bytes).to eq([*0x00..0x7f])
    end
  end

  describe "ASCII" do
    subject { described_class::ASCII }

    it "must contain ASCII bytes 0x00 - 0xff" do
      expect(subject.bytes).to eq([*0x00..0xff])
    end
  end

  {
    :numeric => :NUMERIC,
    :digits  => :DIGITS,
    :octal   => :OCTAL,

    :uppercase_hexadecimal => :UPPERCASE_HEXADECIMAL,
    :lowercase_hexadecimal => :LOWERCASE_HEXADECIMAL,
    :hexadecimal => :HEXADECIMAL,

    :uppercase_alpha => :UPPERCASE_ALPHA,
    :lowercase_alpha => :LOWERCASE_ALPHA,
    :alpha => :ALPHA,

    :visible     => :VISIBLE,
    :punctuation => :PUNCTUATION,
    :symbols     => :SYMBOLS,
    :whitespace  => :WHITESPACE,
    :space       => :SPACE,
    :visible     => :VISIBLE,
    :printable   => :PRINTABLE,
    :control     => :CONTROL,

    :signed_ascii => :SIGNED_ASCII,
    :ascii        => :ASCII
  }.each do |method,constant|
    describe ".#{method}" do
      it "must return #{constant}" do
        expect(subject.send(method)).to be(described_class.const_get(constant))
      end
    end
  end
end
