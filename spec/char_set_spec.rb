require 'spec_helper'
require 'chars/char_set'

require 'securerandom'

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

      it "must encode them as ASCII 8bit Strings" do
        expect(subject.chars.map(&:encoding)).to all(be(Encoding::ASCII_8BIT))
      end

      context "when one of the Integers is greater than 0xff" do
        let(:integers) { [0x100, 0xffff] }

        it "must encode the Integer as a UTF-8 String" do
          expect(subject.chars.map(&:encoding)).to all(be(Encoding::UTF_8))
        end
      end
    end

    context "when given an Array of Integers" do
      subject { described_class.new(integers) }

      it "must populate the char set using the Integers as bytes" do
        expect(integers.all? { |i| subject.include?(i) }).to be(true)
      end

      it "must encode them as ASCII 8bit Strings" do
        expect(subject.chars.map(&:encoding)).to all(be(Encoding::ASCII_8BIT))
      end

      context "when one of the Integers is greater than 0xff" do
        let(:integers) { [0x100, 0xffff] }

        it "must encode the Integer as a UTF-8 String" do
          expect(subject.chars.map(&:encoding)).to all(be(Encoding::UTF_8))
        end
      end
    end

    context "when given a Range of Integers" do
      subject { described_class.new(integer_range) }

      it "must populate the char set by enumerating over the Integer's bytes" do
        expect(integers.all? { |i| subject.include?(i) }).to be(true)
      end

      it "must encode them as ASCII 8bit Strings" do
        expect(subject.chars.map(&:encoding)).to all(be(Encoding::ASCII_8BIT))
      end

      context "when one of the Integers is greater than 0xff" do
        let(:integer_range) { (0x100..0x200) }

        it "must encode the Integer as a UTF-8 String" do
          expect(subject.chars.map(&:encoding)).to all(be(Encoding::UTF_8))
        end
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

    context "when given random: rng" do
      let(:rng) { SecureRandom }

      it "must call the #rand method" do
        expect(rng).to receive(:rand).with(subject.length).and_return(1)

        subject.random_byte(random: rng)
      end
    end
  end

  describe "#random_char" do
    it "should return a random char" do
      expect(subject.include_char?(subject.random_char)).to be(true)
    end

    context "when given random: rng" do
      let(:rng) { SecureRandom }

      it "must call the #rand method" do
        expect(rng).to receive(:rand).with(subject.length).and_return(1)

        subject.random_char(random: rng)
      end
    end
  end

  describe "#each_random_byte" do
    let(:n) { 10 }

    it "should iterate over n random bytes" do
      expect(subject.each_random_byte(n).all? { |b|
        subject.include?(b)
      }).to be(true)
    end

    context "when given random: rng" do
      let(:rng) { SecureRandom }

      it "must call the #rand method n times" do
        n.times do
          expect(rng).to receive(:rand).with(subject.length).and_return(1)
        end

        subject.each_random_byte(n, random: rng) { |b| }
      end
    end
  end

  describe "#each_random_char" do
    let(:n) { 10 }

    it "should iterate over n random chars" do
      expect(subject.each_random_char(10).all? { |c|
        subject.include_char?(c)
      }).to be(true)
    end

    context "when given random: rng" do
      let(:rng) { SecureRandom }

      it "must call the #rand method n times" do
        n.times do
          expect(rng).to receive(:rand).with(subject.length).and_return(1)
        end

        subject.each_random_char(n, random: rng) { |c| }
      end
    end
  end

  describe "#random_bytes" do
    context "when given an Integer" do
      let(:n) { 10 }

      it "should return a random Array of bytes" do
        random_bytes = subject.random_bytes(n)

        expect(random_bytes.all? { |b| subject.include?(b) }).to be(true)
      end

      context "when given random: rng" do
        let(:rng) { SecureRandom }

        it "must call the #rand method n times" do
          n.times do
            expect(rng).to receive(:rand).with(subject.length).and_return(1)
          end

          subject.random_bytes(n, random: rng)
        end
      end
    end

    context "when given a Range of lengths" do
      let(:lengths) { 5..10 }

      it "should return a random Array of bytes with a varying length" do
        random_bytes = subject.random_bytes(lengths)

        expect(random_bytes.length).to be_between(lengths.begin, lengths.end)
        expect(random_bytes.all? { |b| subject.include?(b) }).to be(true)
      end

      context "and when given random: rng" do
        let(:rng) { SecureRandom }

        it "must pass random: to Range#sample" do
          expect(rng).to receive(:rand).and_return(rand(lengths)).at_least(:once)

          random_bytes = subject.random_bytes(lengths, random: rng)

          expect(random_bytes.length).to be_between(lengths.begin, lengths.end)
        end
      end
    end
  end

  describe "#random_chars" do
    context "when given an Integer" do
      let(:n) { 10 }

      it "should return a random Array of chars" do
        random_chars = subject.random_chars(n)

        expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
      end

      context "when given random: rng" do
        let(:rng) { SecureRandom }

        it "must call the #rand method n times" do
          n.times do
            expect(rng).to receive(:rand).with(subject.length).and_return(rand(n))
          end

          subject.random_chars(n, random: rng)
        end
      end
    end

    context "when given a Range of lengths" do
      let(:lengths) { 5..10 }

      it "should return a random Array of chars with a varying length" do
        random_chars = subject.random_chars(lengths)

        expect(random_chars.length).to be_between(lengths.begin, lengths.end)
        expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
      end

      context "and when given random: rng" do
        let(:rng) { SecureRandom }

        it "must pass random: to Range#sample" do
          expect(rng).to receive(:rand).and_return(rand(lengths)).at_least(:once)

          random_chars = subject.random_chars(lengths, random: rng)

          expect(random_chars.length).to be_between(lengths.begin, lengths.end)
        end
      end
    end
  end

  describe "#random_string" do
    context "when given an Integer" do
      let(:n) { 10 }

      it "should return a random String of chars" do
        random_string = subject.random_string(n)

        expect(random_string.chars.all? { |b|
          subject.include_char?(b)
        }).to be(true)
      end

      context "when given random: rng" do
        let(:rng) { SecureRandom }

        it "must call the #rand method n times" do
          expect(rng).to receive(:rand).with(subject.length).and_return(rand(n)).at_least(:once)

          subject.random_chars(n, random: rng)
        end
      end
    end

    context "when given a Range of lengths" do
      let(:lengths) { 5..10 }

      it "should return a random String of chars with a varying length" do
        random_string = subject.random_string(lengths)

        expect(random_string.length).to be_between(lengths.begin, lengths.end)
        expect(random_string.chars.all? { |b|
          subject.include_char?(b)
        }).to be(true)
      end

      context "and when given random: rng" do
        let(:rng) { SecureRandom }

        it "must pass random: to Range#sample" do
          expect(rng).to receive(:rand).and_return(rand(lengths)).at_least(:once)

          random_string = subject.random_string(lengths, random: rng)

          expect(random_string.length).to be_between(lengths.begin, lengths.end)
        end
      end
    end
  end
  
  describe "#random_distinct_bytes" do
    context "when given an Integer" do
      let(:n) { 10 }

      it "should return a random Array of unique bytes" do
        random_bytes = subject.random_distinct_bytes(n)

        expect(random_bytes.length).to eq(n)
        expect(random_bytes.uniq).to be == random_bytes
        expect(random_bytes.all? { |b| subject.include_byte?(b) }).to be(true)
      end

      context "when given random: rng" do
        let(:rng) { SecureRandom }

        it "must call the Array#shuffle with random: rng" do
          expect_any_instance_of(Array).to receive(:shuffle).with(random: rng).and_return(subject.bytes.shuffle)

          subject.random_distinct_bytes(n, random: rng)
        end
      end
    end

    context "with a Range of lengths" do
      let(:lengths) { 5..10 }

      it "should return a random Array of unique bytes with a varying length" do
        random_bytes = subject.random_distinct_bytes(lengths)

        expect(random_bytes.uniq).to be == random_bytes
        expect(random_bytes.length).to be_between(lengths.begin, lengths.end)
        expect(random_bytes.all? { |b| subject.include_byte?(b) }).to be(true)
      end

      context "and when given random: rng" do
        let(:rng) { SecureRandom }

        it "must pass random: to Range#sample" do
          expect(rng).to receive(:rand).and_return(rand(lengths)).at_least(:once)

          random_bytes = subject.random_bytes(lengths, random: rng)

          expect(random_bytes.length).to be_between(lengths.begin, lengths.end)
        end
      end
    end
  end

  describe "#random_distinct_chars" do
    let(:n) { 10 }

    it "should return a random Array of unique chars" do
      random_chars = subject.random_distinct_chars(n)

      expect(random_chars.uniq).to be == random_chars
      expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
    end

    context "when given random: rng" do
      let(:rng) { SecureRandom }

      it "must call the Array#shuffle with random: rng" do
        expect_any_instance_of(Array).to receive(:shuffle).with(random: rng).and_return(subject.bytes.shuffle(random: rng))

        subject.random_distinct_bytes(n, random: rng)
      end
    end

    context "when given a Range of lengths" do
      let(:lengths) { 5..10 }

      it "should return a random Array of unique chars with a varying length" do
        random_chars = subject.random_distinct_chars(lengths)

        expect(random_chars.uniq).to be == random_chars
        expect(random_chars.length).to be_between(lengths.begin, lengths.end)
        expect(random_chars.all? { |c| subject.include_char?(c) }).to be(true)
      end

      context "and when given random: rng" do
        let(:rng) { SecureRandom }

        it "must pass random: to Range#sample" do
          expect(rng).to receive(:rand).and_return(rand(lengths)).at_least(:once)

          random_bytes = subject.random_bytes(lengths, random: rng)

          expect(random_bytes.length).to be_between(lengths.begin, lengths.end)
        end
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

  describe "#substrings_with_indexes" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must return the Array of substrings and their indexes" do
      expect(subject.substrings_with_indexes(string)).to eq(
        [
          ["AAAA", string.index("AAAA")],
          ["BBBB", string.index("BBBB")],
          ["CCCC", string.index("CCCC")]
        ]
      )
    end
  end

  describe "#each_substring(&block : (String) ->)" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must yield each matching substring" do
      expect { |b|
        subject.each_substring(string,&b)
      }.to yield_successive_args(
        "AAAA",
        "BBBB",
        "CCCC"
      )
    end
  end

  describe "#substrings" do
    subject { described_class.new(['A', 'B', 'C']) }

    let(:string) { "....AAAA....BBBB....CCCC...." }

    it "must return the Array of matching substrings" do
      expect(subject.substrings(string)).to eq(
        [
          "AAAA",
          "BBBB",
          "CCCC"
        ]
      )
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

  describe "#each_string" do
    let(:length) { 2 }

    let(:expected_strings) do
      Chars::StringEnumerator.new(subject,length).to_a
    end

    context "when a block is given" do
      it "must enumerate through the strings belonging to the character set of the desired length" do
        expect { |b|
          subject.each_string_of_length(length,&b)
        }.to yield_successive_args(*expected_strings)
      end

      context "when given a Range of lengths" do
        let(:length) { 1..2 }

        let(:expected_strings) do
          Chars::StringEnumerator.new(subject,1).to_a +
          Chars::StringEnumerator.new(subject,2).to_a
        end

        it "must yield strings of lengths in the Range of lengths" do
          expect { |b|
            subject.each_string_of_length(length,&b)
          }.to yield_successive_args(*expected_strings)
        end
      end

      context "when given an Array of lengths" do
        let(:length) { [1,2] }

        let(:expected_strings) do
          Chars::StringEnumerator.new(subject,1).to_a +
          Chars::StringEnumerator.new(subject,2).to_a
        end

        it "must yield strings of lengths in the Range of lengths" do
          expect { |b|
            subject.each_string_of_length(length,&b)
          }.to yield_successive_args(*expected_strings)
        end
      end
    end

    context "when no block is given" do
      it "must return an Enumerator" do
        expect(subject.each_string_of_length(length)).to be_kind_of(Enumerator)
        expect(subject.each_string_of_length(length).to_a).to eq(expected_strings)
      end
    end
  end

  describe "#strings_of_length" do
    let(:length) { 2 }

    let(:expected_strings) do
      Chars::StringEnumerator.new(subject,length).to_a
    end

    it "must return an Enumerator" do
      expect(subject.strings_of_length(length)).to be_kind_of(Enumerator)
      expect(subject.strings_of_length(length).to_a).to eq(expected_strings)
    end
  end

  describe "#===" do
    it "should determine if a String is made up of the characters from the char set" do
      expect(subject).to be === "AABCBAA"
      expect(subject).to_not be === "AA!!EE"
    end
  end
end
