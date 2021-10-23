#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))

require 'chars'
require 'benchmark'

CHARSET = Chars::ALPHA_NUMERIC
STRING  = File.open('/usr/bin/openssl','rb') do |file|
            file.read
          end

Benchmark.bm(24) do |b|
  b.report('strings_in') do
    CHARSET.strings_in(STRING) { |offset,string| }
  end

  (5..20).step(5) do |n|
    b.report("strings_in (length=#{n})") do
      CHARSET.strings_in(STRING, :length => n) { |offset,string| }
    end
  end
end
