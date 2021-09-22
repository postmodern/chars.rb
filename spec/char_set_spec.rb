require 'spec_helper'
require 'chars/char_set'

describe Chars::CharSet do
  let(:integer_range) { (0x41..0x43) }
  let(:string_range)  { ('A'..'Z') }
  let(:integers)      { integer_range.to_a }
  let(:strings)       { string_range.to_a }

  subject { described_class.new(*strings) }

  describe "#initialize" do
    context "when given multiple String arguments" do
      subject { described_class.new(*strings) }

      it "must populate the char set with the String's chars" do
        expect(strings.all? { |s| subject.include_char?(s) }).to be(true)
      end
    end

    context "when given an Array of Strings" do
      subject { described_class.new(strings) }

      it "must populate the char set with the String's chars" do
        expect(strings.all? { |s| subject.include_char?(s) }).to be(true)
      end
    end

    context "when given a Range of Strings" do
      subject { described_class.new(string_range) }

      it "must populate the char set by enumerating over the String's chars" do
        expect(strings.all? { |s| subject.include_char?(s) }).to be(true)
      end
    end

    context "when given multiple Integer arguments" do
      subject { described_class.new(*integers) }

      it "must populate the char set using the Integers as bytes" do
        expect(integers.all? { |i| subject.include?(i) }).to be(true)
      end
    end

    context "when given an Array of Integers" do
      subject { described_class.new(integers) }

      it "must populate the char set using the Integers as bytes" do
        expect(integers.all? { |i| subject.include?(i) }).to be(true)
      end
    end

    context "when given a Range of Integers" do
      subject { described_class.new(integer_range) }

      it "must populate the char set by enumerating over the Integer's bytes" do
        expect(integers.all? { |i| subject.include?(i) }).to be(true)
      end
    end
  end

  describe "#include_char?" do
    it "should include Strings" do
      expect(subject.include_char?('A')).to be(true)
    end
  end

  describe "#include?" do
    it "should include Integers" do
      expect(subject).to include(0x41)
    end
  end

  describe "#select_bytes" do
    it "should be able to select bytes" do
      sub_set = subject.select_bytes { |c| c <= 0x42 }

      expect(sub_set).to be == [0x41, 0x42]
    end
  end

  describe "#select_chars" do
    it "should be able to select chars" do
      sub_set = subject.select_chars { |c| c <= 'B' }

      expect(sub_set).to be == ['A', 'B']
    end
  end

  describe "#random_byte" do
    it "should return a random byte" do
      expect(subject).to include(subject.random_byte)
    end
  end

  describe "#random_char" do
    it "should return a random char" do
      expect(subject.include_char?(subject.random_char)).to be(true)
    end
  end

  describe "#each_random_byte" do
    it "should iterate over n random bytes" do
      expect(subject.each_random_byte(10).all? { |b|
        subject.include?(b)
      }).to be(true)
    end
  end

  describe "#each_random_char" do
    it "should iterate over n random chars" do
      expect(subject.each_random_char(10).all? { |c|
        subject.include_char?(c)
      }).to be(true)
    end
  end

  describe "#random_bytes" do
    it "should return a random Array of bytes" do
      random_bytes = subject.random_bytes(10)

      expect(random_bytes.all? { |b| subject.include?(b) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of bytes with a varying length" do
        random_bytes = subject.random_bytes(5..10)

        expect(random_bytes.length).to be_between(5, 10)
        expect(random_bytes.all? { |b| subject.include?(b) }).to be(true)
      end
    end
  end

  describe "#random_chars" do
    it "should return a random Array of chars" do
      random_chars = subject.random_chars(10)

      expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of chars with a varying length" do
        random_chars = subject.random_chars(5..10)

        expect(random_chars.length).to be_between(5, 10)
        expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
      end
    end
  end

  describe "#random_string" do
    it "should return a random String of chars" do
      random_string = subject.random_string(10)

      expect(random_string.chars.all? { |b|
        subject.include_char?(b)
      }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random String of chars with a varying length" do
        random_string = subject.random_string(5..10)

        expect(random_string.length).to be_between(5, 10)
        expect(random_string.chars.all? { |b|
          subject.include_char?(b)
        }).to be(true)
      end
    end
  end
  
  describe "#random_distinct_bytes" do
    it "should return a random Array of unique bytes" do
      random_bytes = subject.random_distinct_bytes(10)

      expect(random_bytes.uniq).to be == random_bytes
      expect(random_bytes.all? { |b| subject.include_byte?(b) }).to be(true)
    end

    context "with a Range of lengths" do
      it "should return a random Array of unique bytes with a varying length" do
        random_bytes = subject.random_distinct_bytes(5..10)

        expect(random_bytes.uniq).to be == random_bytes
        expect(random_bytes.length).to be_between(5, 10)
        expect(random_bytes.all? { |b| subject.include_byte?(b) }).to be(true)
      end
    end
  end

  describe "#random_distinct_chars" do
    it "should return a random Array of unique chars" do
      random_chars = subject.random_distinct_chars(10)

      expect(random_chars.uniq).to be == random_chars
      expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
    end

    context "with a range of lengths" do
      it "should return a random Array of unique chars with a varying length" do
        random_chars = subject.random_distinct_chars(5..10)

        expect(random_chars.uniq).to be == random_chars
        expect(random_chars.length).to be_between(5, 10)
        expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
      end
    end
  end

  describe "#==" do
    it "should be able to be compared with another set of chars" do
      expect(subject).to be == described_class['A'..'Z']
    end
  end

  describe "#|" do
    it "should be able to be unioned with another set of chars" do
      super_set = (subject | described_class['D'])

      expect(super_set).to be_kind_of(described_class)
      expect(super_set).to be == described_class['A'..'Z', 'D']
    end
  end

  describe "#-" do
    it "should be able to be removed from another set of chars" do
      sub_set = (subject - described_class['B'])

      expect(sub_set).to be_kind_of(described_class)
      expect(sub_set).to be_subset(subject)
    end
  end

  describe "#each_substring_with_index" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must yield each matching substring and index" do
      expect { |b|
        subject.each_substring_with_index(string,&b)
      }.to yield_successive_args(
        ["AAAA", string.index("AAAA")],
        ["BBBB", string.index("BBBB")],
        ["CCCC", string.index("CCCC")]
      )
    end

    context "when the string begins with a matching substring" do
      let(:string) { "AAAA...." }

      it "must yield the first matching substring" do
        expect(subject.each_substring_with_index(string).first).to eq(
          ["AAAA", 0]
        )
      end
    end

    context "when the string ends with a matching substring" do
      let(:string) { "AAAA....BBBB....CCCC" }

      it "must yield the last matching substring" do
        expect(subject.each_substring_with_index(string).to_a.last).to eq(
          ["CCCC", string.rindex("CCCC")]
        )
      end
    end

    context "when the entire string is a matching substring" do
      let(:string) { "AAAAAAAA" }

      it "must yield the entire string" do
        expect { |b|
          subject.each_substring_with_index(string,&b)
        }.to yield_successive_args( [string, 0] )
      end
    end

    context "when the matching substrings are shorter than the min_length" do
      let(:min_length) { 2 }

      let(:string) { "AA..B...CC.."}

      it "must ignore the substrings shorter than min_length" do
        expect { |b|
          subject.each_substring_with_index(string, min_length: min_length, &b)
        }.to yield_successive_args(
          ["AA", string.index("AA")],
          ["CC", string.index("CC")]
        )
      end
    end

    context "when min_length 0" do
      let(:min_length) { 0 }

      let(:string) { "A.BB..CCC..."}

      it "must yield all matching substrings, regardless of length" do
        expect { |b|
          subject.each_substring_with_index(string, min_length: min_length, &b)
        }.to yield_successive_args(
          ["A",   string.index("A")],
          ["BB",  string.index("BB")],
          ["CCC", string.index("CCC")]
        )
      end
    end
  end

  describe "#strings_in" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "AAAA....BBBB....CCCC...." }

    context "when given a block" do
      it "should find sub-strings from a String belonging to the char set" do
        expect { |b|
          subject.strings_in(string,&b)
        }.to yield_successive_args(
          "AAAA",
          "BBBB",
          "CCCC"
        )
      end

      it "must find sub-strings of a minimum length of 4" do
        expect { |b|
          subject.strings_in("A...BBB...CCCC",&b)
        }.to yield_successive_args("CCCC")
      end

      context "and when the whole string matches the char set" do
        it "should find one sub-string from a String belonging to the char set" do
          expect { |b|
            subject.strings_in("AAAA",&b)
          }.to yield_successive_args("AAAA")
        end
      end

      context "when the :length option is given" do
        it "must find sub-strings of the given minimum length" do
          expect { |b|
            subject.strings_in("AAAA...BBBB...CCCCC", :length => 5, &b)
          }.to yield_successive_args("CCCCC")
        end
      end

      context "and when the block takes two arguments" do
        it "must yield the sub-strings and their indexes" do
          yielded_args = []

          subject.strings_in(string) do |substring,index|
            yielded_args << [substring, index]
          end

          expect(yielded_args).to eq(
            [
              ['AAAA', string.index('AAAA')],
              ['BBBB', string.index('BBBB')],
              ['CCCC', string.index('CCCC')]
            ]
          )
        end
      end
    end

    context "when no block is given" do
      it "must return an Array of sub-strings" do
        expect(subject.strings_in(string)).to eq(
          [
            "AAAA",
            "BBBB",
            "CCCC"
          ]
        )
      end

      context "when given the :offset option" do
        it "must return a Hash of the substrings and their indexes" do
          expect(subject.strings_in(string, :offsets => true)).to eq(
            {
              "AAAA" => string.index("AAAA"),
              "BBBB" => string.index("BBBB"),
              "CCCC" => string.index("CCCC")
            }
          )
        end
      end
    end
  end

  describe "#===" do
    it "should determine if a String is made up of the characters from the char set" do
      expect(subject).to be === "AABCBAA"
      expect(subject).to_not be === "AA!!EE"
    end
  end
end
