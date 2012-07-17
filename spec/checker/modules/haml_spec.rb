require 'spec_helper'

describe Checker::Modules::Haml do
  it 'should only check .haml files' do
    files = ['a.rb', 'b.js.erb', 'c.r', 'd.yml', 'e.yaml', 'f.coffee', 'g.haml']
    mod = Checker::Modules::Haml.new(files)
    mod.stub(:check_for_executable).and_return(true)
    mod.stub(:check_one).and_return(true)
    mod.should_receive(:check_one).with('g.haml')
    mod.should_not_receive(:check_one).with('f.coffee')
    mod.should_not_receive(:check_one).with('e.yaml')
    mod.should_not_receive(:check_one).with('d.yml')
    mod.should_not_receive(:check_one).with('a.rb')
    mod.should_not_receive(:check_one).with('b.js.erb')
    mod.should_not_receive(:check_one).with('c.r')
    mod.check 
  end
end