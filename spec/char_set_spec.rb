require 'spec_helper'
require 'chars/chars'

describe Chars::CharSet do
  let(:integer_range) { (0x41..0x43) }
  let(:string_range)  { ('A'..'Z') }
  let(:integers)      { integer_range.to_a }
  let(:strings)       { string_range.to_a }

  subject { described_class.new(*strings) }

  describe "#initialize" do
    it "may be created with String arguments" do
      set = described_class.new(*strings)

      expect(strings.all? { |s| set.include_char?(s) }).to be(true)
    end

    it "may be created with an Array of Strings" do
      set = described_class.new(strings)

      expect(strings.all? { |s| set.include_char?(s) }).to be(true)
    end

    it "may be created with a Range of Strings" do
      set = described_class.new(string_range)

      expect(strings.all? { |s| set.include_char?(s) }).to be(true)
    end

    it "may be created with Integer arguments" do
      set = described_class.new(*integers)

      expect(integers.all? { |i| set.include?(i) }).to be(true)
    end

    it "may be created with an Array of Integers" do
      set = described_class.new(integers)

      expect(integers.all? { |i| set.include?(i) }).to be(true)
    end

    it "may be created with a Range of Integers" do
      set = described_class.new(integer_range)

      expect(integers.all? { |i| set.include?(i) }).to be(true)
    end
  end

  it "should include Strings" do
    expect(subject.include_char?('A')).to be(true)
  end

  it "should include Integers" do
    expect(subject).to include(0x41)
  end

  it "should be able to select bytes" do
    sub_set = subject.select_bytes { |c| c <= 0x42 }

    expect(sub_set).to be == [0x41, 0x42]
  end

  it "should be able to select chars" do
    sub_set = subject.select_chars { |c| c <= 'B' }

    expect(sub_set).to be == ['A', 'B']
  end

  it "should return a random byte" do
    expect(subject).to include(subject.random_byte)
  end

  it "should return a random char" do
    expect(subject.include_char?(subject.random_char)).to be(true)
  end

  it "should iterate over n random bytes" do
    expect(subject.each_random_byte(10).all? { |b|
      subject.include?(b)
    }).to be(true)
  end

  it "should iterate over n random chars" do
    expect(subject.each_random_char(10).all? { |c|
      subject.include_char?(c)
    }).to be(true)
  end

  describe "#random_bytes" do
    it "should return a random Array of bytes" do
      bytes = subject.random_bytes(10)

      expect(bytes.all? { |b| subject.include?(b) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of bytes with a varying length" do
        bytes = subject.random_bytes(5..10)

        expect(bytes.length).to be_between(5, 10)
        expect(bytes.all? { |b| subject.include?(b) }).to be(true)
      end
    end
  end

  describe "#random_chars" do
    it "should return a random Array of chars" do
      chars = subject.random_chars(10)

      expect(chars.all? { |c| subject.include_char?(c) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of chars with a varying length" do
        chars = subject.random_chars(5..10)

        expect(chars.length).to be_between(5, 10)
        expect(chars.all? { |c| subject.include_char?(c) }).to be(true)
      end
    end
  end

  describe "#random_string" do
    it "should return a random String of chars" do
      string = subject.random_string(10)

      expect(string.chars.all? { |b| subject.include_char?(b) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random String of chars with a varying length" do
        string = subject.random_string(5..10)

        expect(string.length).to be_between(5, 10)
        expect(string.chars.all? { |b| subject.include_char?(b) }).to be(true)
      end
    end
  end
  
  describe "#random_distinct_bytes" do
    it "should return a random Array of unique bytes" do
      bytes = subject.random_distinct_bytes(10)

      expect(bytes.uniq).to be == bytes
      expect(bytes.all? { |b| subject.include?(b) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of unique bytes with a varying length" do
        bytes = subject.random_distinct_bytes(5..10)

        expect(bytes.uniq).to be == bytes
        expect(bytes.length).to be_between(5, 10)
        expect(bytes.all? { |b| subject.include?(b) }).to be(true)
      end
    end
  end

  describe "#random_distinct_chars" do
    it "should return a random Array of unique chars" do
      chars = subject.random_distinct_chars(10)

      expect(chars.uniq).to be == chars
      expect(chars.all? { |c| subject.include_char?(c) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of unique chars with a varying length" do
        chars = subject.random_distinct_chars(5..10)

        expect(chars.uniq).to be == chars
        expect(chars.length).to be_between(5, 10)
        expect(chars.all? { |c| subject.include_char?(c) }).to be(true)
      end
    end
  end

  it "should be able to be compared with another set of chars" do
    expect(subject).to be == described_class['A'..'Z']
  end

  it "should be able to be unioned with another set of chars" do
    super_set = (subject | described_class['D'])

    expect(super_set).to be_kind_of(described_class)
    expect(super_set).to be == described_class['A'..'Z', 'D']
  end

  it "should be able to be removed from another set of chars" do
    sub_set = (subject - described_class['B'])

    expect(sub_set).to be_kind_of(described_class)
    expect(sub_set).to be_subset(subject)
  end

  describe "#strings_in" do
    it "should find one sub-string from a String belonging to the char set" do
      expect(subject.strings_in("AAAA")).to be == ["AAAA"]
    end

    it "should find sub-strings from a String belonging to the char set" do
      expect(subject.strings_in("AAAA!B!CCCCCC")).to be == [
        "AAAA",
        "CCCCCC"
      ]
    end
  end

  it "should determine if a String is made up of the characters from the char set" do
    expect(subject).to be === "AABCBAA"
    expect(subject).to_not be === "AA!!EE"
  end
end
