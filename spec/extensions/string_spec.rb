require 'spec_helper'
require 'chars/extensions/string'

describe 'chars/extensions/string' do
  let(:root) { File.expand_path(File.join('..','..'),__dir__) }
  let(:path) { File.join(root,'lib','chars','core_ext', 'string.rb') }

  it "must require 'chars/core_ext/string'" do
    expect($LOADED_FEATURES).to include(path)
  end
end
