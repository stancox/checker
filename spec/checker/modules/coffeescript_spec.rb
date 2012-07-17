require 'spec_helper'

describe Checker::Modules::Coffeescript do
  it 'should only check .coffee files' do
    files = ['a.rb', 'b.js.erb', 'c.r', 'd.yml', 'e.yaml', 'f.coffee']
    mod = Checker::Modules::Coffeescript.new(files)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).with('f.coffee')
    mod.should_not_receive(:check_one).with('e.yaml')
    mod.should_not_receive(:check_one).with('d.yaml')
    mod.should_not_receive(:check_one).with('a.rb')
    mod.should_not_receive(:check_one).with('b.js.erb')
    mod.should_not_receive(:check_one).with('c.r')
    mod.check 
  end
end