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

      strings.all? { |s| set.include_char?(s) }.should == true
    end

    it "may be created with an Array of Strings" do
      set = described_class.new(strings)

      strings.all? { |s| set.include_char?(s) }.should == true
    end

    it "may be created with a Range of Strings" do
      set = described_class.new(string_range)

      strings.all? { |s| set.include_char?(s) }.should == true
    end

    it "may be created with Integer arguments" do
      set = described_class.new(*integers)

      integers.all? { |i| set.include?(i) }.should == true
    end

    it "may be created with an Array of Integers" do
      set = described_class.new(integers)

      integers.all? { |i| set.include?(i) }.should == true
    end

    it "may be created with a Range of Integers" do
      set = described_class.new(integer_range)

      integers.all? { |i| set.include?(i) }.should == true
    end
  end

  it "should include Strings" do
    subject.include_char?('A').should == true
  end

  it "should include Integers" do
    subject.should include(0x41)
  end

  it "should be able to select bytes" do
    sub_set = subject.select_bytes { |c| c <= 0x42 }

    sub_set.should == [0x41, 0x42]
  end

  it "should be able to select chars" do
    sub_set = subject.select_chars { |c| c <= 'B' }

    sub_set.should == ['A', 'B']
  end

  it "should return a random byte" do
    subject.should include(subject.random_byte)
  end

  it "should return a random char" do
    subject.include_char?(subject.random_char).should == true
  end

  it "should iterate over n random bytes" do
    subject.each_random_byte(10).all? { |b|
      subject.include?(b)
    }.should == true
  end

  it "should iterate over n random chars" do
    subject.each_random_char(10).all? { |c|
      subject.include_char?(c)
    }.should == true
  end

  it "should return a random Array of bytes" do
    bytes = subject.random_bytes(10)

    bytes.all? { |b| subject.include?(b) }.should == true
  end

  it "should return a random Array of chars" do
    chars = subject.random_chars(10)

    chars.all? { |c| subject.include_char?(c) }.should == true
  end

  it "should return a random Array of bytes with a varying length" do
    bytes = subject.random_bytes(5..10)

    bytes.length.should be_between(5, 10)
    bytes.all? { |b| subject.include?(b) }.should == true
  end

  it "should return a random Array of chars with a varying length" do
    chars = subject.random_chars(5..10)

    chars.length.should be_between(5, 10)
    chars.all? { |c| subject.include_char?(c) }.should == true
  end

  it "should return a random String of chars" do
    string = subject.random_string(10)
    
    string.chars.all? { |b| subject.include_char?(b) }.should == true
  end

  it "should return a random String of chars with a varying length" do
    string = subject.random_string(5..10)

    string.length.should be_between(5, 10)
    string.chars.all? { |b| subject.include_char?(b) }.should == true
  end
  
  it "should return a random Array of unique bytes" do
    bytes = subject.random_distinct_bytes(10)

    bytes.uniq.should == bytes
    bytes.all? { |b| subject.include?(b) }.should == true
  end

  it "should return a random Array of unique chars" do
    chars = subject.random_distinct_chars(10)

    chars.uniq.should == chars
    chars.all? { |c| subject.include_char?(c) }.should == true
  end

  it "should return a random Array of unique bytes with a varying length" do
    bytes = subject.random_distinct_bytes(5..10)

    bytes.uniq.should == bytes
    bytes.length.should be_between(5, 10)
    bytes.all? { |b| subject.include?(b) }.should == true
  end

  it "should return a random Array of unique chars with a varying length" do
    chars = subject.random_distinct_chars(5..10)

    chars.uniq.should == chars
    chars.length.should be_between(5, 10)
    chars.all? { |c| subject.include_char?(c) }.should == true
  end

  it "should be able to be compared with another set of chars" do
    subject.should == described_class['A'..'Z']
  end

  it "should be able to be unioned with another set of chars" do
    super_set = (subject | described_class['D'])

    super_set.class.should == described_class
    super_set.should == described_class['A'..'Z', 'D']
  end

  it "should be able to be removed from another set of chars" do
    sub_set = (subject - described_class['B'])

    sub_set.class.should == described_class
    sub_set.should be_subset(subject)
  end

  it "should find one sub-string from a String belonging to the char set" do
    subject.strings_in("AAAA").should == ["AAAA"]
  end

  it "should find sub-strings from a String belonging to the char set" do
    subject.strings_in("AAAA!B!CCCCCC").should == [
      "AAAA",
      "CCCCCC"
    ]
  end

  it "should determine if a String is made up of the characters from the char set" do
    (subject === "AABCBAA").should be_true
    (subject === "AA!!EE").should be_false
  end
end
