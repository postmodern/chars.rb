#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),'..','lib'))

require 'chars'
require 'benchmark'

CHARSET = Chars::ALPHA_NUMERIC
N       = 1_000_000
STRING  = ('A' * N) + '!'
ENUM    = (['A', 0x42] * (N / 2)) << '!'

Benchmark.bm(12) do |b|
  b.report('String')     { CHARSET === STRING }
  b.report('Enumerable') { CHARSET === ENUM }
end
