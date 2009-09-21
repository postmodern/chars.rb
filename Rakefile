# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './tasks/spec.rb'
require './tasks/yard.rb'

Hoe.spec('chars') do
  self.rubyforge_name = 'chars'
  self.developer('Postmodern','postmodern.mod3@gmail.com')
  self.remote_rdoc_dir = '/'
  self.extra_deps = [
    ['yard', '>=0.2.3.5']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.2.8']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=Ruby
