#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))

require 'chars'
require 'benchmark'

CHARSET = Chars::ALPHA_NUMERIC
STRING  = File.binread('/usr/bin/openssl')

Benchmark.bm(41) do |b|
  b.report('Chars::CharSet#each_substring_with_index') do
    CHARSET.each_substring_with_index(STRING) { |string,index| }
  end

  b.report('Chars::CharSet#each_substring') do
    CHARSET.each_substring(STRING) { |string| }
  end

  (5..20).step(5) do |n|
    b.report("Chars::CharSet#each_substring (length=#{n})") do
      CHARSET.strings_in(STRING, :length => n) { |offset,string| }
    end
  end
end
