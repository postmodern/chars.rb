require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/chars/version.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'chars'
  gem.version = Chars::VERSION
  gem.summary = %Q{A Ruby library for working with various character sets}
  gem.description = %Q{Chars is a Ruby library for working with various character sets, recognizing text and generating random text from specific character sets.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/postmodern/chars'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
