require 'spec_helper'

describe Checker::Modules::Sass do
  it 'should only check .sass and .scss files' do
    files = ['a.rb', 'b.js.erb', 'c.r', 'd.yml', 'e.yaml', 'f.coffee', 'g.haml', 'h.js', 'i.scss', 'j.sass']
    mod = Checker::Modules::Sass.new(files)
    mod.stub(:check_for_executable).and_return(true)
    mod.stub(:check_one_file).and_return(true)
    mod.should_receive(:check_one_file).with('j.sass')
    mod.should_receive(:check_one_file).with('i.scss')
    mod.should_not_receive(:check_one_file).with('h.js')
    mod.should_not_receive(:check_one_file).with('g.haml')
    mod.should_not_receive(:check_one_file).with('f.coffee')
    mod.should_not_receive(:check_one_file).with('e.yaml')
    mod.should_not_receive(:check_one_file).with('d.yml')
    mod.should_not_receive(:check_one_file).with('a.rb')
    mod.should_not_receive(:check_one_file).with('b.js.erb')
    mod.should_not_receive(:check_one_file).with('c.r')
    mod.check 
  end
end
