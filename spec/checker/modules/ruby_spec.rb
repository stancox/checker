require 'spec_helper'

describe Checker::Modules::Ruby do
  it 'should only check .rb files' do
    files = ['a.rb', 'b.js.erb', 'c.r']
    mod = Checker::Modules::Ruby.new(files)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).once
    mod.check 
  end
end