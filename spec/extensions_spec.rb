require 'spec_helper'
require 'chars/extensions'

describe "chars/extensions" do
  let(:root) { File.expand_path('..',__dir__) }
  let(:path) { File.join(root,'lib','chars','core_ext.rb') }

  it "must require 'chars/core_ext'" do
    expect($LOADED_FEATURES).to include(path)
  end
end
