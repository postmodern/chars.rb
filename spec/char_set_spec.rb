require 'spec_helper'
require 'chars/chars'

describe Chars::CharSet do
  before(:all) do
    @integer_range = (0x41..0x43)
    @string_range = ('A'..'Z')
    @integers = @integer_range.to_a
    @strings = @string_range.to_a

    @char_set = described_class.new(*@strings)
  end

  describe "#initialize" do
    it "may be created with String arguments" do
      @chars = described_class.new(*@strings)

      @strings.all? { |s| @chars.include_char?(s) }.should == true
    end

    it "may be created with an Array of Strings" do
      @chars = described_class.new(@strings)

      @strings.all? { |s| @chars.include_char?(s) }.should == true
    end

    it "may be created with a Range of Strings" do
      @chars = described_class.new(@string_range)

      @strings.all? { |s| @chars.include_char?(s) }.should == true
    end

    it "may be created with Integer arguments" do
      @chars = described_class.new(*@integers)

      @integers.all? { |i| @chars.include?(i) }.should == true
    end

    it "may be created with an Array of Integers" do
      @chars = described_class.new(@integers)

      @integers.all? { |i| @chars.include?(i) }.should == true
    end

    it "may be created with a Range of Integers" do
      @chars = described_class.new(@integer_range)

      @integers.all? { |i| @chars.include?(i) }.should == true
    end
  end

  it "should include Strings" do
    @char_set.include_char?('A').should == true
  end

  it "should include Integers" do
    @char_set.should include(0x41)
  end

  it "should be able to select bytes" do
    @sub_chars = @char_set.select_bytes { |c| c <= 0x42 }

    @sub_chars.should == [0x41, 0x42]
  end

  it "should be able to select chars" do
    @sub_chars = @char_set.select_chars { |c| c <= 'B' }

    @sub_chars.should == ['A', 'B']
  end

  it "should return a random byte" do
    @char_set.should include(@char_set.random_byte)
  end

  it "should return a random char" do
    @char_set.include_char?(@char_set.random_char).should == true
  end

  it "should iterate over n random bytes" do
    @char_set.each_random_byte(10).all? { |b|
      @char_set.include?(b)
    }.should == true
  end

  it "should iterate over n random chars" do
    @char_set.each_random_char(10).all? { |c|
      @char_set.include_char?(c)
    }.should == true
  end

  it "should return a random Array of bytes" do
    bytes = @char_set.random_bytes(10)

    bytes.all? { |b| @char_set.include?(b) }.should == true
  end

  it "should return a random Array of chars" do
    chars = @char_set.random_chars(10)

    chars.all? { |c| @char_set.include_char?(c) }.should == true
  end

  it "should return a random Array of bytes with a varying length" do
    bytes = @char_set.random_bytes(5..10)

    bytes.length.should be_between(5, 10)
    bytes.all? { |b| @char_set.include?(b) }.should == true
  end

  it "should return a random Array of chars with a varying length" do
    chars = @char_set.random_chars(5..10)

    chars.length.should be_between(5, 10)
    chars.all? { |c| @char_set.include_char?(c) }.should == true
  end

  it "should return a random String of chars" do
    string = @char_set.random_string(10)
    
    string.chars.all? { |b| @char_set.include_char?(b) }.should == true
  end

  it "should return a random String of chars with a varying length" do
    string = @char_set.random_string(5..10)

    string.length.should be_between(5, 10)
    string.chars.all? { |b| @char_set.include_char?(b) }.should == true
  end
  
  it "should return a random Array of unique bytes" do
    bytes = @char_set.random_distinct_bytes(10)

    bytes.uniq.should == bytes
    bytes.all? { |b| @char_set.include?(b) }.should == true
  end

  it "should return a random Array of unique chars" do
    chars = @char_set.random_distinct_chars(10)

    chars.uniq.should == chars
    chars.all? { |c| @char_set.include_char?(c) }.should == true
  end

  it "should return a random Array of unique bytes with a varying length" do
    bytes = @char_set.random_distinct_bytes(5..10)

    bytes.uniq.should == bytes
    bytes.length.should be_between(5, 10)
    bytes.all? { |b| @char_set.include?(b) }.should == true
  end

  it "should return a random Array of unique chars with a varying length" do
    chars = @char_set.random_distinct_chars(5..10)

    chars.uniq.should == chars
    chars.length.should be_between(5, 10)
    chars.all? { |c| @char_set.include_char?(c) }.should == true
  end

  it "should be able to be compared with another set of chars" do
    @char_set.should == described_class['A'..'Z']
  end

  it "should be able to be unioned with another set of chars" do
    super_set = (@char_set | described_class['D'])

    super_set.class.should == described_class
    super_set.should == described_class['A'..'Z', 'D']
  end

  it "should be able to be removed from another set of chars" do
    sub_set = (@char_set - described_class['B'])

    sub_set.class.should == described_class
    sub_set.should be_subset(@char_set)
  end

  it "should find one sub-string from a String belonging to the char set" do
    @char_set.strings_in("AAAA").should == ["AAAA"]
  end

  it "should find sub-strings from a String belonging to the char set" do
    @char_set.strings_in("AAAA!B!CCCCCC").should == [
      "AAAA",
      "CCCCCC"
    ]
  end

  it "should determine if a String is made up of the characters from the char set" do
    @char_set.should === "AABCBAA"
    @char_set.should_not === "AA!!EE"
  end
end
