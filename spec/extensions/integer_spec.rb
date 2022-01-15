require 'spec_helper'
require 'chars/extensions/integer'

describe 'chars/extensions/integer' do
  let(:root) { File.expand_path(File.join('..','..'),__dir__) }
  let(:path) { File.join(root,'lib','chars','core_ext', 'integer.rb') }

  it "must require 'chars/core_ext/integer'" do
    expect($LOADED_FEATURES).to include(path)
  end
end
