# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'

Hoe.plugin :yard

Hoe.spec('chars') do
  self.developer('Postmodern','postmodern.mod3@gmail.com')

  self.rspec_options += ['--colour', '--format', 'specdoc']

  self.yard_options += ['--markup', 'markdown', '--protected']
  self.remote_yard_dir = '/'

  self.extra_deps = [
    ['yard', '>=0.5.3']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.3.0']
  ]
end

# vim: syntax=Ruby
