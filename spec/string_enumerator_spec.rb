require 'spec_helper'
require 'chars/char_set'
require 'chars/string_enumerator'

describe Chars::StringEnumerator do
  let(:char_set) { Chars::CharSet['a', 'b', 'c'] }
  let(:length)   { 3 }

  subject { described_class.new(char_set,length) }

  describe "#initialize" do
    it "must set #char_set" do
      expect(subject.char_set).to eq(char_set)
    end

    it "must set #length" do
      expect(subject.length).to eq(length)
    end
  end

  describe "#each" do
    let(:expected_strings) do
      %w[
        aaa
        aab
        aac
        aba
        abb
        abc
        aca
        acb
        acc
        baa
        bab
        bac
        bba
        bbb
        bbc
        bca
        bcb
        bcc
        caa
        cab
        cac
        cba
        cbb
        cbc
        cca
        ccb
        ccc
      ]
    end

    context "when a block is given" do
      it "must enumerate through each sequential string in the char-set and of the desired length" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(*expected_strings)
      end

      context "when the length is 1" do
        let(:length) { 1 }

        it "must enumerate over each individual character" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args(*char_set.chars)
        end
      end

      context "when the length is 0" do
        let(:length) { 0 }

        it "must yield an empty String" do
          expect { |b|
            subject.each(&b)
          }.to yield_successive_args("")
        end
      end

      context "when #char_set is empty" do
        let(:char_set) { Chars::CharSet.new }

        it "must yield an empty String" do
          expect { |b|
            subject.each(&b)
          }.to_not yield_control
        end
      end
    end

    context "when no block is given" do
      it "must return an Enumerator object" do
        expect(subject.each).to be_kind_of(Enumerator)
        expect(subject.each.to_a).to eq(expected_strings)
      end
    end
  end
end
